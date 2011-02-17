package info.simonrichardson.mvc.patterns.command
{
	import info.simonrichardson.mvc.ICommand;
	import info.simonrichardson.mvc.patterns.observer.SignalMap;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class AbstractCommand extends SignalMap implements ICommand
	{

		public function AbstractCommand(notification : String)
		{
			super(notification);
		}

		protected function execute() : void
		{
		}

		public function get listener() : Function
		{
			return execute;
		}

		public function get valueClasses() : Array
		{
			return null;
		}

		override public function toString() : String
		{
			return "[AbstractCommand (notification=" + name + "]";
		}
	}
}
