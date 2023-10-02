package linkedlist

import (
	"errors"
)

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
	newNode := &Node{Value: v}
	if l.Head != nil {
		newNode.next = l.Head
		l.Head.prev = newNode
	}
	l.Head = newNode
	if l.Tail == nil {
		l.Tail = newNode
	}
}

func (l *List) Push(v interface{}) {
	newNode := &Node{Value: v}
	if l.Tail != nil {
		newNode.prev = l.Tail
		l.Tail.next = newNode
	}
	l.Tail = newNode
	if l.Head == nil {
		l.Head = newNode
	}
}

func (l *List) Shift() (interface{}, error) {
	if l.Head == nil {
		return nil, errors.New("Cannot shift an empty list")
	}
	result := l.Head.Value
	l.Head = l.Head.next
	if l.Head != nil {
		l.Head.prev = nil
	} else {
		l.Tail = l.Head
	}
	return result, nil
}

func (l *List) Pop() (interface{}, error) {
	if l.Tail == nil {
		return nil, errors.New("Cannot pop from an empty list")
	}
	result := l.Tail.Value
	l.Tail = l.Tail.prev
	if l.Tail != nil {
		l.Tail.next = nil
	} else {
		l.Head = l.Tail
	}
	return result, nil
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
