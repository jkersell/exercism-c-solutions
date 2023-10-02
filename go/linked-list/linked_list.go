package linkedlist

type List struct {
	Head *Node
	Tail *Node
}

type Node struct {
	prev *Node
	next *Node
	Value interface{}
}

func NewList(elements ...interface{}) *List {
	list := List{}
	var currentNode *Node
	for _, e := range elements {
		nextNode := &Node{Value: e}
		if list.Head == nil {
			list.Head = nextNode
			currentNode = list.Head
		} else if currentNode.next == nil {
			currentNode.next = nextNode
			nextNode.prev = currentNode
			currentNode = currentNode.next
		}
		list.Tail = currentNode
	}
	return &list
}

func (n *Node) Next() *Node {
	return n.next
}

func (n *Node) Prev() *Node {
	return n.prev
}

func (l *List) Unshift(v interface{}) {
	panic("Please implement the Unshift function")
}

func (l *List) Push(v interface{}) {
	panic("Please implement the Push function")
}

func (l *List) Shift() (interface{}, error) {
	panic("Please implement the Shift function")
}

func (l *List) Pop() (interface{}, error) {
	panic("Please implement the Pop function")
}

func (l *List) Reverse() {
	l.Tail = l.Head
	currentNode := l.Head
	if currentNode == nil {
		return
	}
	for currentNode != nil {
		tempPrev := currentNode.prev
		currentNode.prev = currentNode.next
		currentNode.next = tempPrev
		l.Head = currentNode
		currentNode = currentNode.prev
	}
}

func (l *List) First() *Node {
	return l.Head
}

func (l *List) Last() *Node {
	return l.Tail
}
