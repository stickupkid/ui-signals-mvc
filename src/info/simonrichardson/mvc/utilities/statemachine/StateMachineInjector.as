package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.patterns.observer.SignalMap;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class StateMachineInjector extends SignalMap
	{

		public static const STATE_MACHINE_PROXY_NAME : String = "stateMachineProxyName";

		public static const STATE_MACHINE_MEDIATOR_NAME : String = "stateMachineMediatorName";

		public static const NAME : String = "StateMachineInjector";

		public function StateMachineInjector(name : String)
		{
			super(name);
		}

		public function inject(xml : XML) : void
		{
			const proxyName : String = STATE_MACHINE_PROXY_NAME;
			const proxy : StateMachineProxy = new StateMachineProxy(proxyName);
			
			const mediatorName : String = STATE_MACHINE_MEDIATOR_NAME;
			const mediator : StateMachineMediator = new StateMachineMediator(mediatorName, proxyName);

			const initial : String = xml.@initial;

			const stateDefinitions : XMLList = xml..child("state");
			const total : int = stateDefinitions.length();
			for (var i : int = 0; i < total; i++)
			{
				const stateDefinition : XML = stateDefinitions[i];
				const stateName : String = stateDefinition.@name;
				const stateNotification : String = stateDefinition.@notification;
				const stateDefault : String = stateDefinition.@initial;

				const state : State = new State(stateName, stateNotification, stateDefault);

				const internalDefinitions : XMLList = stateDefinition..child("internal");
				const internalTotal : int = internalDefinitions.length();
				for (var j : int = 0; j < internalTotal; j++)
				{
					const internalDefinition : XML = internalDefinitions[j];
					const internalName : String = internalDefinition.@name;
					const internalNotification : String = internalDefinition.@notification;

					const internalState : InternalState = state.createInternalState(internalName, internalNotification);

					const transitionDefinitions : XMLList = internalDefinition..child("transition");
					const transitionTotal : int = transitionDefinitions.length();
					for (var k : int = 0; k < transitionTotal; k++)
					{
						const transitionDefinition : XML = transitionDefinitions[k];
						const transitionAction : String = transitionDefinition.@action;
						const transitionInternalTarget : String = transitionDefinition.attribute("internal");

						var transitionTarget : String = transitionDefinition.@target;

						if (null == transitionTarget || transitionTarget == "")
						{
							transitionTarget = stateName;
						}

						if ((null != transitionInternalTarget && transitionInternalTarget != "") && (transitionTarget != stateName))
						{
							throw new ReferenceError("You can not move to another states internal state.");
						}

						const transition : StateTransition = internalState.createTransition(transitionAction, transitionTarget, transitionInternalTarget);

						internalState.addTransition(transition);
					}

					state.addInternalState(internalState);
				}

				proxy.addState(state, state.name == initial);
			}
			
			facade.registerMediator(mediator);
			facade.registerProxy(proxy);
		}
	}
}
