package info.simonrichardson.mvc.core
{
	import info.simonrichardson.mvc.IFacade;
	import info.simonrichardson.mvc.ICommand;
	import info.simonrichardson.mvc.IController;
	import info.simonrichardson.mvc.IView;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class Controller implements IController
	{

		protected var _view : IView;

		protected var _facade : IFacade;

		protected var _commandMap : Dictionary;

		public function Controller()
		{
			_commandMap = new Dictionary(true);
		}

		public function initialize(facade : IFacade, view : IView) : void
		{
			_view = view;
			_facade = facade;
		}

		public function registerCommand(command : ICommand) : void
		{
			if (null != command.valueClasses)
			{
				if (command.valueClasses.length != command.listener.length)
				{
					throw new ArgumentError('Invalid listener parameter length');
				}
			}
			
			if(null == command.listener)
			{
				throw new ArgumentError('Invalid listener');
			}

			command.initialize(_facade, _view);

			if ( _commandMap[ command.name ] == null )
			{
				_view.addHook(command);
			}

			_commandMap[ command.name ] = command;
		}

		public function removeCommand(command : ICommand) : void
		{
			if ( hasCommand(command.name) )
			{
				_view.removeHook(command);
				_commandMap[ command.name ] = null;
			}
		}

		public function hasCommand(commandName : String) : Boolean
		{
			return _commandMap[ commandName ] != null;
		}
	}
}
