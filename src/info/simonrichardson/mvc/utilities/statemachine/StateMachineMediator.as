package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.errors.NoSuchElementError;
	import info.simonrichardson.errors.NullReferenceError;
	import info.simonrichardson.mvc.IHook;
	import info.simonrichardson.mvc.patterns.mediator.Mediator;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class StateMachineMediator extends Mediator
	{

		private var _proxy : StateMachineProxy;

		private var _proxyName : String;

		public function StateMachineMediator(name : String, proxyName : String)
		{
			super(name);

			_proxyName = proxyName;
		}

		override public function listSignalHooks() : Vector.<IHook>
		{
			const hooks : Vector.<IHook> = super.listSignalHooks();
			hooks.push(new StateMachineActionHook(actionHandler));
			hooks.push(new StateMachineCancelHook(cancelledHandler));
			return hooks;
		}

		private function actionHandler(action : String) : void
		{
			const currentState : State = proxy.currentState;
			if (null == currentState)
			{
				throw new NullReferenceError("Current state can not be null.");
			}

			if (action == StateMachineActionHook.NEXT_STATE)
			{
				const index : int = proxy.getStateIndex(currentState);
				if (index >= 0)
				{
					const nextState : State = proxy.getStateAt(index + 1);
					if (null == nextState)
					{
						throw new Error("No next state available to move to.");
					}
					else
					{
						proxy.transitionToState(nextState);
					}
				}
				else
				{
					throw new NoSuchElementError();
				}
			}
			else
			{
				const currentInternalState : InternalState = currentState.currentInternalState;
				if (null == currentInternalState)
				{
					throw new NullReferenceError("Current internal state can not be null.");
				}

				var transition : StateTransition;
				if (action == StateMachineActionHook.NEXT_INTERNAL_STATE)
				{
					if (currentInternalState.numTransitions == 0)
					{
						throw new Error("No transitions to move to next.");
					}
					else if (currentInternalState.numTransitions > 1)
					{
						throw new Error("Ambiguous event, unable to decide which transition to move to.");
					}
					else
					{
						transition = currentInternalState.getTransitionByAt(0);
					}
				}
				else
				{
					transition = currentInternalState.getTransitionByAction(action);
					if (null == transition)
					{
						throw new NullReferenceError("Current internal transtion not found (action=" + action + ")");
					}
				}

				if (transition.target == proxy.currentState.name)
				{
					const internalState : InternalState = currentState.getInternalStateByName(transition.internalTarget);
					if (null == internalState)
					{
						throw new NullReferenceError("Next internal state can not be null (next target=" + transition.target + ")");
					}

					proxy.transitionToInternalState(internalState);
				}
				else
				{
					const state : State = proxy.getStateByName(transition.target);
					if (null == state)
					{
						throw new NullReferenceError("Next state can not be null (next target=" + transition.target + ")");
					}

					proxy.transitionToState(state);
				}
			}
		}

		private function cancelledHandler() : void
		{
			proxy.cancelled = true;
		}

		private function get proxy() : StateMachineProxy
		{
			if (null == _proxy)
			{
				_proxy = facade.retrieveProxy(_proxyName) as StateMachineProxy;
				if (null == _proxy)
				{
					throw new NullReferenceError();
				}
			}

			return _proxy;
		}
	}
}
