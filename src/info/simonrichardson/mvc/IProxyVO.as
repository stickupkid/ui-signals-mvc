package info.simonrichardson.mvc
{
	import info.simonrichardson.interfaces.IDisposable;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface IProxyVO extends IDisposable
	{

		function clone() : IProxyVO;

		function toString() : String;
	}
}
