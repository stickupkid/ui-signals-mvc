package info.simonrichardson.mvc.utilities.statemachine
{
	import info.simonrichardson.mvc.IProxyVO;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class State implements IProxyVO
	{

		private var _name : String;

		public var entering : String;

		public var exiting : String;

		public var changed : String;

		protected var transitions : Dictionary;

		public function State(name : String)
		{
			_name = name;

			transitions = new Dictionary(true);
		}

		public function defineTransition(action : String, target : String) : void
		{
			if ( getTarget(action) != null )
			{
				return;
			}
			transitions[ action ] = target;
		}

		public function removeTransition(action : String) : void
		{
			transitions[ action ] = null;
		}

		public function getTarget(action : String) : String
		{
			return transitions[ action ];
		}

		public function clone() : IProxyVO
		{
			const state : State = new State(name);
			state.entering = entering;
			state.exiting = exiting;
			state.changed = changed;

			for each (var item : String in transitions)
			{
				state.transitions[item] = transitions[item];
			}

			return null;
		}

		public function get name() : String
		{
			return _name;
		}

		public function dispose() : void
		{
			for each (var item : String in transitions)
			{
				delete transitions[item];
			}
		}

		public function toString() : String
		{
			return "[State (name=" + name + ")]";
		}
	}
}
