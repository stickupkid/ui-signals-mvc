package info.simonrichardson.mvc.patterns.observer
{
	import info.simonrichardson.mvc.IHook;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class Hook implements IHook
	{

		protected var _name : String;
		
		protected var _listener : Function;
		
		protected var _valueClasses : Array;

		public function Hook(name : String, listener : Function, valueClasses : Array = null)
		{
			_name = name;
			_listener = listener;
			_valueClasses = valueClasses;
		}

		final public function get name() : String
		{
			return _name;
		}

		public function get listener() : Function
		{
			return _listener;
		}

		public function get valueClasses() : Array
		{
			return _valueClasses;
		}
	}
}
