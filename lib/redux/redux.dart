import 'dart:async';

import 'package:flutter/widgets.dart';

/// Base interface for all action types.
abstract class ActionType {}

/// Action for synchronous requests.
abstract class Action<T> implements ActionType {
  /// Method to perform a synchronous mutation on the state.
  T reduce(T state);
}

/// Reducer function type for state mutations.
typedef T Computation<T>(T state);

/// Action for asynchronous requests.
abstract class AsyncAction<T> implements ActionType {
  /// Store for dispatching new actions.
  Store<T> store;

  /// Method to perform a asynchronous mutation on the state.
  Future<Computation<T>> reduce(T state);

  /// A pre computation reduce, useful for loading states.
  T reduceSync(T state) => state;
}

/// Interface for Middlewares.
abstract class Middleware<T> {
  /// Called before action reducer.
  T beforeAction(Store<T> store, ActionType action, T state) => state;

  /// Called after action reducer.
  T afterAction(Store<T> store, ActionType action, T state) => state;
}

/// The heart of the idea, this is where we control the State and dispatch Actions.
class Store<T> with ChangeNotifier {
  /// You can create the Store given an [initialState].

  /// This is where RxDart comes in, we manage the final state using a [BehaviorSubject].

  /// List of middlewares to be applied.
  final List<Middleware> middlewares;

  Store({
    T initialState,
    this.middlewares = const [],
  }) : _state = initialState;

  /// Gets the subject current value/store's current state.
  T _state;

  T get state => _state;

  /// Dispatches actions that mutates the current state.
  Store<T> dispatch(ActionType action) {
    if (action is Action<T>) {
      final afterAction = action.reduce(_computeBeforeMiddlewares(action, _state));
      _state = _foldAfterActionMiddlewares(afterAction, action);
      notifyListeners();
    } else if (action is AsyncAction<T>) {
      action.store = this;

      _state = action.reduceSync(_state);
      notifyListeners();

      action.reduce(_computeBeforeMiddlewares(action, _state)).then((computation) {
        final afterAction = computation(_computeBeforeMiddlewares(action, _state));
        _state = _foldAfterActionMiddlewares(afterAction, action);
        notifyListeners();
      });
    } else {
      middlewares.forEach((middleware) => middleware.afterAction(this, action, state));
    }

    return this;
  }

  /// Adds middlewares to the store.
  Store<T> add(Middleware<T> middleware) {
    middlewares.add(middleware);
    return this;
  }

  T _computeBeforeMiddlewares(ActionType action, T state) =>
      middlewares.fold<T>(state, (state, middleware) => middleware.beforeAction(this, action, state));

  T _foldAfterActionMiddlewares(T initialValue, ActionType action) =>
      middlewares.fold<T>(initialValue, (state, middleware) => middleware.afterAction(this, action, state));
}
