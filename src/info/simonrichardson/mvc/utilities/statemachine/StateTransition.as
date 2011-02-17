package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.IProxyVO;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class StateTransition implements IProxyVO
	{

		private var _action : String;

		private var _target : String;

		private var _internalTarget : String;

		public function StateTransition(action : String, target : String, internalTarget : String)
		{
			_action = action;
			_target = target;
			_internalTarget = internalTarget;
		}

		public function clone() : IProxyVO
		{
			return new StateTransition(action, target, internalTarget);
		}

		public function get action() : String
		{
			return _action;
		}

		public function get target() : String
		{
			return _target;
		}

		public function get internalTarget() : String
		{
			return _internalTarget;
		}

		public function dispose() : void
		{
		}

		public function toString() : String
		{
			return "[StateTransition (action=" + action + ", target=" + target + ", internal=" + internalTarget + ")]";
		}
	}
}
