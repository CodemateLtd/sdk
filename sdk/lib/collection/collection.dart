// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Classes and utilities that supplement the collection support in dart:core.
///
/// To use this library in your code:
/// ```dart
/// import 'dart:collection';
/// ```
///
/// ## List
/// An indexable collection of objects, objects can be accessed through index
/// of list. [List] is also called an "array" in other programming languages.
///
/// ## Map
/// A collection of key/value pairs, from which to retrieve a value
/// using the associated key. [Map] is a base class of functionality;
/// custom functionalities are, for example:
/// * [HashMap] is unordered (no order is guaranteed)
/// * [LinkedHashMap] iterates in key insertion order
/// * [SplayTreeMap] iterates the keys in sorted order
/// * [UnmodifiableMapView] map type where items modification is not allowed
///
/// ## Set
/// A collection of objects in which each object can occur only once.
/// [Set] is a base class of functionality, customized functionalities
/// are, for example:
/// * [HashSet] is unordered, which means that its iteration order is
///   unspecified
/// * [LinkedHashSet] iterates in the insertion order of its elements
/// * [SplayTreeSet] iterates the elements in sorted order
/// * [UnmodifiableSetView] set type where item's modification is not allowed
///
/// ## Queue
/// A queue is a collection that can be processed at both ends.
/// No access to object data through the index, access to first and last object.
/// * [Queue] is a base class for queue. [ListQueue] is returned.
/// * [ListQueue] is a queue-based list.
/// * [DoubleLinkedQueue] is a queue implementation based on a
///   double-linked list.
///
/// ## LinkedList
/// [LinkedList] is a specialized double-linked list of elements that extends
/// [LinkedListEntry]. Each element knows its place in the linked list and
/// in which list it is.
/// {@category Core}
library dart.collection;

import 'dart:_internal' hide Symbol;
import 'dart:math' show Random; // Used by ListMixin.shuffle.

export 'dart:_internal' show DoubleLinkedQueueEntry;

part 'collections.dart';
part 'hash_map.dart';
part 'hash_set.dart';
part 'iterable.dart';
part 'iterator.dart';
part 'linked_hash_map.dart';
part 'linked_hash_set.dart';
part 'linked_list.dart';
part 'list.dart';
part 'maps.dart';
part 'queue.dart';
part 'set.dart';
part 'splay_tree.dart';
