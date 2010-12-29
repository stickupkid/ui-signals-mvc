package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface IHook
	{
		
		function get name() : String;
		
		function get listener() : Function;

		function get valueClasses() : Array;
	}
}
