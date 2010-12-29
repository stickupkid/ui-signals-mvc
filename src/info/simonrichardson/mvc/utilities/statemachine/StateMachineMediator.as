package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.errors.NullReferenceError;
	import info.simonrichardson.mvc.IHook;
	import info.simonrichardson.mvc.patterns.mediator.Mediator;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class StateMachineMediator extends Mediator
	{

		private var _proxy : StateMachineProxy;
		
		private var _proxyName : String;

		public function StateMachineMediator(name : String, proxyName : String)
		{
			super(name);

			_proxyName = proxyName;
		}

		override public function onRegister() : void
		{
			_proxy = facade.retrieveProxy(_proxyName) as StateMachineProxy;
			if (null == _proxy)
			{
				throw new NullReferenceError();
			}
		}

		override public function listSignalHooks() : Vector.<IHook>
		{
			const hooks : Vector.<IHook> = super.listSignalHooks();
			hooks.push(new StateMachineActionHook(actionHandler));
			hooks.push(new StateMachineCancelHook(cancelledHandler));
			return hooks;
		}

		private function actionHandler(type : String) : void
		{
			const target : String = _proxy.currentState.getTarget(type);
			const newState : State = _proxy.states[ target ];

			if ( newState )
			{
				_proxy.transitionTo(newState);
			}
		}

		private function cancelledHandler() : void
		{
			_proxy.cancelled = true;
		}
	}
}
