package linkedlist

import (
	"errors"
)

type List struct {
	head *Node
	tail *Node
}

type Node struct {
	prev *Node
	next *Node
	Value interface{}
}

func NewList(elements ...interface{}) *List {
	list := List{}
	for _, e := range elements {
		list.Push(e)
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
	if l.head != nil {
		newNode.next = l.head
		l.head.prev = newNode
	}
	l.head = newNode
	if l.tail == nil {
		l.tail = newNode
	}
}

func (l *List) Push(v interface{}) {
	newNode := &Node{Value: v}
	if l.tail != nil {
		newNode.prev = l.tail
		l.tail.next = newNode
	}
	l.tail = newNode
	if l.head == nil {
		l.head = newNode
	}
}

func (l *List) Shift() (interface{}, error) {
	if l.head == nil {
		return nil, errors.New("Cannot shift an empty list")
	}
	result := l.head.Value
	l.head = l.head.next
	if l.head != nil {
		l.head.prev = nil
	} else {
		l.tail = l.head
	}
	return result, nil
}

func (l *List) Pop() (interface{}, error) {
	if l.tail == nil {
		return nil, errors.New("Cannot pop from an empty list")
	}
	result := l.tail.Value
	l.tail = l.tail.prev
	if l.tail != nil {
		l.tail.next = nil
	} else {
		l.head = l.tail
	}
	return result, nil
}

func (l *List) Reverse() {
	l.tail = l.head
	currentNode := l.head
	if currentNode == nil {
		return
	}
	for currentNode != nil {
		tempPrev := currentNode.prev
		currentNode.prev = currentNode.next
		currentNode.next = tempPrev
		l.head = currentNode
		currentNode = currentNode.prev
	}
}

func (l *List) First() *Node {
	return l.head
}

func (l *List) Last() *Node {
	return l.tail
}
