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

			facade.registerProxy(proxy);

			const mediatorName : String = STATE_MACHINE_MEDIATOR_NAME;
			const mediator : StateMachineMediator = new StateMachineMediator(mediatorName, proxyName);

			facade.registerMediator(mediator);

			const initial : String = xml.@initial;

			const stateDefinitions : XMLList = xml..child("state");
			const total : int = stateDefinitions.length();
			for (var i : int; i < total; i++)
			{
				const stateDefinition : XML = stateDefinitions[i];

				const stateName : String = stateDefinition.@name;

				const state : State = new State(stateName);
				state.entering = stateDefinition.@entering;
				state.changed = stateDefinition.@changed;
				state.exiting = stateDefinition.@exiting;

				const transitions : XMLList = stateDefinition..child("transition");
				const transitionTotal : int = transitions.length();
				for (var j : int; j < transitionTotal; j++)
				{
					const transDefinition : XML = transitions[j];
					state.defineTransition(transDefinition.@action, transDefinition.@target);
				}

				proxy.registerState(state, state.name == initial);
			}
		}
	}
}
