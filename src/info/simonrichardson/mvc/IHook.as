package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IHook
	{
		
		function get name() : String;
		
		function get listener() : Function;

		function get valueClasses() : Array;
	}
}
