
# Python program to concatenate two strings using
# rope data structure.
 
# Maximum no. of characters to be put in leaf nodes
LEAF_LEN = 2
 
# Rope structure
class Rope:
 
    def __init__(self):
        self.left = None
        self.right = None
        self.parent = None
        self.str = [0]*(LEAF_LEN + 1)
        self.lCount = 0
 
# Function that creates a Rope structure.
# node --> Reference to pointer of current root node
# l  --> Left index of current substring (initially 0)
# r  --> Right index of current substring (initially n-1)
# par --> Parent of current node (Initially NULL)
def createRopeStructure(node, par, a, l, r):
 
    tmp = Rope()
    tmp.left = tmp.right = None # why?
  
    # We put half nodes in left subtree
    tmp.parent = par
  
    # If string length is more
    if (r-l) > LEAF_LEN:
 
        tmp.str = None
        tmp.lCount = (r-l) // 2
        node = tmp
        m = (l + r) // 2
        createRopeStructure(node.left, node, a, l, m)
        createRopeStructure(node.right, node, a, m+1, r)
    else:
         
        node = tmp
        tmp.lCount = (r-l)
        j = 0
        for i in range(l, r+1):
            print(a[i],end = \"\")
            tmp.str[j] = a[i]
            j = j + 1
        print(end = \"\")
     
    return node
 
# Function that prints the string (leaf nodes)
def printstring(r):
 
    if r==None:
        return
     
    if r.left==None and r.right==None:
        pass
 
    printstring(r.left)
    printstring(r.right)
 
# Function that efficiently concatenates two strings
# with roots root1 and root2 respectively. n1 is size of
# string represented by root1.
# root3 is going to store root of concatenated Rope.
def concatenate(root3, root1, root2, n1):
     
    # Create a new Rope node, and make root1 
    # and root2 as children of tmp.
    tmp = Rope()
    tmp.left = root1
    tmp.right = root2
    root1.parent = tmp
    root2.parent = tmp
    tmp.lCount = n1
 
    # Make string of tmp empty and update 
    # reference r
    tmp.str = None
    root3 = tmp
     
    return root3
 
# Driver code
# Create a Rope tree for first string
root1 = None
a =  \"Hi This is geeksforgeeks. \"
n1 = len(a)
root1 = createRopeStructure(root1, None, a, 0, n1-1)
 
# Create a Rope tree for second string
root2 = None
b =  \"You are welcome here.\"
n2 = len(b)
root2 = createRopeStructure(root2, None, b, 0, n2-1)
 
# Concatenate the two strings in root3.
root3 = None
root3 = concatenate(root3, root1, root2, n1)
 
# Print the new concatenated string
printstring(root3)
print()
 
# The code is contributed by Nidhi goel. 
