package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface ICommand extends IHook
	{
		
		function initialize(facade : IFacade, view : IView) : void;
	}
}
