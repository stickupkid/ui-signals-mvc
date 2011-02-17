package info.simonrichardson.mvc
{
	import info.simonrichardson.interfaces.IDisposable;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IProxyVO extends IDisposable
	{

		function clone() : IProxyVO;

		function toString() : String;
	}
}
