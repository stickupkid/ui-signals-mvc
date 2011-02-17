package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.errors.ElementAlreadyExistsError;
	import info.simonrichardson.errors.NullReferenceError;
	import info.simonrichardson.mvc.patterns.proxy.Proxy;

	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class StateMachineProxy extends Proxy
	{

		protected var initial : State;

		private var _states : Vector.<State>;

		private var _cancelled : Boolean;

		public function StateMachineProxy(name : String)
		{
			super(name);

			_cancelled = false;
			_states = new Vector.<State>();
		}

		override public function onRegister() : void
		{
			if (null != initial)
			{
				transitionToState(initial);
			}
		}

		public function getStateByName(name : String) : State
		{
			var index : int = _states.length;
			while (--index > -1)
			{
				const state : State = _states[index];
				if (state.name == name)
				{
					return state;
				}
			}
			return null;
		}

		public function addState(state : State, initial : Boolean = false) : void
		{
			if ( null == state)
			{
				throw new ArgumentError("State can not be null");
			}

			if (getStateByName(state.name) != null)
			{
				throw new ElementAlreadyExistsError();
			}

			_states.push(state);

			if ( initial )
			{
				this.initial = state;
			}

			state.build();
		}

		public function getStateAt(index : int) : State
		{
			if (index < 0 || index >= _states.length)
			{
				throw new RangeError();
			}

			return _states[index];
		}

		public function getStateIndex(state : State) : int
		{
			return _states.indexOf(state);
		}

		public function removeState(state : State) : void
		{
			const index : int = getStateIndex(state);
			if ( index == -1 )
			{
				return;
			}

			_states.splice(index, 1);

			state.dispose();
		}

		internal function transitionToState(nextState : State) : void
		{
			if (null == nextState)
			{
				throw new NullReferenceError();
			}

			if (cancelled || currentState == nextState)
			{
				return;
			}

			if (null != currentState)
			{
				currentState.currentInternalState = null;
			}

			currentState = nextState;

			var signal : ISignal;
			signal = getSignal(StateMachineChangedHook.CHANGED);
			if (null != signal)
			{
				signal.dispatch();
			}

			if (null != nextState.notification && nextState.notification != "")
			{
				signal = getSignal(nextState.notification);
				if (null != signal)
				{
					signal.dispatch();
				}
			}

			_cancelled = false;

			if (null != currentState.initial)
			{
				const internalState : InternalState = currentState.getInternalStateByName(currentState.initial);
				if (null != internalState && currentState.currentInternalState == internalState)
				{
					signal = getSignal(StateMachineChangedHook.CHANGED);
					if (null != signal)
					{
						signal.dispatch();
					}

					if (null != internalState.notification && internalState.notification != "")
					{
						signal = getSignal(internalState.notification);
						if (null != signal)
						{
							signal.dispatch();
						}
					}
				}
				else
				{
					transitionToInternalState(internalState);
				}
			}
		}

		internal function transitionToInternalState(nextInternalState : InternalState) : void
		{
			if (null == nextInternalState)
			{
				throw new NullReferenceError();
			}

			if (cancelled)
			{
				return;
			}

			if (currentState.currentInternalState == nextInternalState)
			{
				return;
			}

			currentState.currentInternalState = nextInternalState;

			var signal : ISignal;
			signal = getSignal(StateMachineChangedHook.CHANGED);
			if (null != signal)
			{
				signal.dispatch();
			}

			if (null != nextInternalState.notification && nextInternalState.notification != "")
			{
				signal = getSignal(nextInternalState.notification);
				if (null != signal)
				{
					signal.dispatch();
				}
			}

			_cancelled = false;
		}

		internal function get states() : Vector.<State>
		{
			return _states;
		}

		internal function get cancelled() : Boolean
		{
			return _cancelled;
		}

		internal function set cancelled(value : Boolean) : void
		{
			_cancelled = value;
		}

		public function get currentState() : State
		{
			return data as State;
		}

		public function set currentState(state : State) : void
		{
			data = state;
		}

		override public function toString() : String
		{
			return "[StateMachineProxy]";
		}
	}
}
