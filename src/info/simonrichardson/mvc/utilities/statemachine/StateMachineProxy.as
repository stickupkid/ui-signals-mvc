package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.patterns.proxy.Proxy;

	import org.osflash.signals.ISignal;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class StateMachineProxy extends Proxy
	{

		protected var initial : State;

		private var _states : Dictionary;

		private var _cancelled : Boolean;

		public function StateMachineProxy(name : String)
		{
			super(name);

			_states = new Dictionary(true);
		}

		override public function onRegister() : void
		{
			if (null != initial)
			{
				transitionTo(initial);
			}
		}

		public function retrieveState(name : String) : State
		{
			return _states[ name ];
		}

		public function registerState(state : State, initial : Boolean = false) : void
		{
			if ( state == null || _states[ state.name ] != null )
			{
				return;
			}

			_states[ state.name ] = state;

			if ( initial )
			{
				this.initial = state;
			}
		}

		public function removeState(stateName : String) : void
		{
			const state : State = _states[ stateName ];
			if ( state == null )
			{
				return;
			}

			state.dispose();

			_states[ stateName ] = null;
		}

		internal function transitionTo(nextState : State) : void
		{
			if ( nextState == null )
			{
				return;
			}

			cancelled = false;

			var signal : ISignal;

			if ( currentState && currentState.exiting )
			{
				signal = getSignal(currentState.exiting);
				if (null != signal)
				{
					signal.dispatch(nextState.name);
				}

				// sendNotification(currentState.exiting, data, nextState.name);
			}

			if ( cancelled )
			{
				cancelled = false;
				return;
			}

			if ( nextState.entering )
			{
				signal = getSignal(currentState.entering);
				if (null != signal)
				{
					signal.dispatch();
				}

				// sendNotification(nextState.entering, data);
			}

			if ( cancelled )
			{
				cancelled = false;
				return;
			}

			currentState = nextState;

			signal = getSignal(StateMachineChangedHook.CHANGED);
			if (null != signal)
			{
				signal.dispatch(currentState);
			}

			if ( nextState.changed )
			{
				signal = getSignal(currentState.changed);
				if (null != signal)
				{
					signal.dispatch();
				}

				// sendNotification(currentState.changed, data);
			}
		}

		internal function get states() : Dictionary
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
