package info.simonrichardson.mvc.patterns.observer
{
	import info.simonrichardson.errors.NullReferenceError;
	import info.simonrichardson.mvc.IFacade;
	import info.simonrichardson.mvc.ISignalMap;
	import info.simonrichardson.mvc.IView;

	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class SignalMap implements ISignalMap
	{

		private var _name : String;

		private var _view : IView;

		private var _facade : IFacade;

		public function SignalMap(name : String)
		{
			_name = name;
		}

		public function initialize(facade : IFacade, view : IView) : void
		{
			_view = view;
			_facade = facade;
		}

		public function getSignal(signalName : String) : ISignal
		{
			if (null == _view)
			{
				throw new NullReferenceError();
			}
			return _view.getSignal(signalName);
		}

		final public function get name() : String
		{
			return _name;
		}

		final public function get facade() : IFacade
		{
			return _facade;
		}

		final public function get view() : IView
		{
			return _view;
		}

		public function toString() : String
		{
			return "[SignalMap]";
		}
	}
}
