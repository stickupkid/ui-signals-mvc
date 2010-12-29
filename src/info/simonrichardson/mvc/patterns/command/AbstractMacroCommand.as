package info.simonrichardson.mvc.patterns.command
{
	import info.simonrichardson.mvc.ICommand;
	import info.simonrichardson.mvc.IMacroCommand;
	import info.simonrichardson.mvc.patterns.observer.SignalMap;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class AbstractMacroCommand extends SignalMap implements IMacroCommand
	{

		private var _commands : Vector.<ICommand>;

		public function AbstractMacroCommand(name : String)
		{
			super(name);
			
			_commands = new Vector.<ICommand>();
		}
		
		public function addCommand(command : ICommand) : void
		{
			if (_commands.indexOf(command) >= 0)
			{
				return;
			}

			if (valueClasses.length != command.valueClasses.length)
			{
				throw new ArgumentError('Invalid valueClasses arguments length');
			}
			
			const commandValueClasses : Array = command.valueClasses;
			for (var i:int = commandValueClasses.length; i--; )
			{
				if (!(commandValueClasses[i] is Class))
				{
					throw new ArgumentError('Invalid valueClasses argument: ' +
						'item at index ' + i + ' should be a Class but was:<' +
						commandValueClasses[i] + '>.' + getQualifiedClassName(commandValueClasses[i]));
				}
				
				const macroClassName : String = getQualifiedClassName(valueClasses[i]);
				const commandClassName : String = getQualifiedClassName(commandValueClasses[i]);
				if(macroClassName != commandClassName)
				{
					throw new ArgumentError('Invalid valueClasses argument: ' +
						'item at index ' + i + ' should be a ' +
						macroClassName + ' but was:<' +
						commandValueClasses[i] + '>.' + commandClassName);
				}
			}
			
			_commands.push(command);
		}

		public function removeCommand(command : ICommand) : void
		{
			const index : int = _commands.indexOf(command);
			if(index == -1)
			{
				return;
			}
			_commands.splice(index, 1);
		}

		public function hasCommand(command : ICommand) : Boolean
		{
			return _commands.indexOf(command) != -1;
		}

		protected function execute() : void
		{
			const total : int = _commands.length;
			for(var i : int = 0; i<total; i++)
			{
				_commands[i].listener.apply(null, arguments);
			}
		}

		public function get listener() : Function
		{
			return execute;
		}

		public function get valueClasses() : Array
		{
			return null;
		}
	}
}
