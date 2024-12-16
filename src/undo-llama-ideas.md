Implementing an undo/redo feature for your text editor involves maintaining a history of edits made to the document. Here's a basic approach using Common Lisp:

### 1. Representing Edits and Document History

First, you'll need a data structure to represent each edit (i.e., addition or deletion of characters at specific positions). A simple way is to use a list where each element is an edit operation. Each edit could be represented as a list `(type position value)`:

- `type` can be one of `'insert`, `'delete`, or other operations like `'replace`.
- `position` is the index within the document where this operation was applied.
- `value` for insertions would be the character inserted, and for deletions, it would also be a character to keep consistency in your history.

For maintaining the undo/redo list:

```lisp
(defclass edit ()
  ((type :initarg :type :accessor get-type)
   (position :initarg :position :accessor get-position)
   (value :initarg :value :accessor get-value)))

(defparameter *undo-redo-list* '())
```

### 2. Creating Edit Operations

Next, you'll need functions to create edit operations:

```lisp
(defun make-insert-edit (doc index character)
  \"Create an insert edit operation.\"
  (make-instance 'edit :type 'insert :position index :value character))

(defun make-delete-edit (doc index)
  \"Create a delete edit operation.\"
  (make-instance 'edit :type 'delete :position index))
```

### 3. Managing the Undo/Redo List

You'll need to implement functions to add, undo, and redo edits in your document history:

```lisp
(defun push-edit (doc edit)
  \"Add an edit operation to the end of the undo-redo list.\"
  (setf *undo-redo-list* (cons edit *undo-redo-list*))
  doc)

(defun pop-last-edit ()
  \"Remove and return the last element from the undo-redo list, or nil if empty.\"
  (when-let ((last (car *undo-redo-list*)))
    (rplacd *undo-redo-list* nil)
    last))

(defun undo-doc ()
  \"Apply the previous edit operation (if any).\"
  (let ((edit (pop-last-edit)))
    (if edit
        (make-instance 'edit-type-case :type edit)
        nil)))

(defun redo-doc ()
  \"Reapply the next edit operation (if any).\"
  (let ((edit (car *undo-redo-list*)))
    (when edit
      (push-edit (setf *undo-redo-list* (cdr *undo-redo-list*)) edit))))

(defclass edit-type-case ()
  ((type :initarg :type)))

(defun make-instance-and-call-slot (class slot-name args)
  \"Convenience function to create an instance and call a specified slot.\"
  (let ((instance (apply #'make-instance class args)))
    (funcall (slot-makunbound instance 'call-slot))
    instance))

(defmethod call-slot ((e edit-type-case))
  (case (get-type e)
    ('insert (format t \"Insert ~A at position ~A~%\" (get-value e) (get-position e)))
    ('delete (format t \"Delete character at position ~A~%\" (get-position e)))))
```

### Example Usage

```lisp
(let ((doc \"Hello, World!\"))
  (push-edit doc (make-insert-edit doc 7 ' '))
  (push-edit doc (make-delete-edit doc 0))
  (call-slot (undo-doc)) ; Undo the delete edit
  (call-slot (redo-doc))) ; Redo the last operation
```

This is a simplified example and might not cover all edge cases of a full-featured text editor. The approach here focuses on demonstrating how to maintain an undo/redo list using Common Lisp objects and methods.

For handling complex operations like replacements, consider adding more types of edits or enhancing your existing ones accordingly.
