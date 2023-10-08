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

	if l.head == nil {
		l.head = newNode
		l.tail = newNode
		return
	}

	newNode.next = l.head
	l.head.prev = newNode
	l.head = newNode
}

func (l *List) Push(v interface{}) {
	newNode := &Node{Value: v}

	if l.tail == nil {
		l.head = newNode
		l.tail = newNode
		return
	}

	newNode.prev = l.tail
	l.tail.next = newNode
	l.tail = newNode
}

func (l *List) Shift() (interface{}, error) {
	if l.head == nil {
		return nil, errors.New("Cannot shift an empty list")
	}

	if l.head == l.tail {
		result := l.head.Value
		l.head = nil
		l.tail = nil
		return result, nil
	}

	unlinkedNode := l.head
	l.head = unlinkedNode.next
	unlinkedNode.next = nil
	l.head.prev = nil
	return unlinkedNode.Value, nil
}

func (l *List) Pop() (interface{}, error) {
	if l.tail == nil {
		return nil, errors.New("Cannot pop from an empty list")
	}

	if l.head == l.tail {
		result := l.tail.Value
		l.head = nil
		l.tail = nil
		return result, nil
	}

	unlinkedNode := l.tail
	l.tail = unlinkedNode.prev
	unlinkedNode.prev = nil
	l.tail.next = nil
	return unlinkedNode.Value, nil
}

func (l *List) Reverse() {
	if l.head == nil {
		return
	}

	currentNode := l.head
	for currentNode != nil {
		currentNode.prev, currentNode.next = currentNode.next, currentNode.prev
		currentNode = currentNode.prev
	}
	l.head, l.tail = l.tail, l.head
}

func (l *List) First() *Node {
	return l.head
}

func (l *List) Last() *Node {
	return l.tail
}
