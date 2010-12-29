package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface IMacroCommand extends ICommand
	{

		function addCommand(command : ICommand) : void;

		function removeCommand(command : ICommand) : void;

		function hasCommand(command : ICommand) : Boolean;
	}
}
