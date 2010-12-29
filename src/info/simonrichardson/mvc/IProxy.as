package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface IProxy extends ISignalMap
	{
				
		function onRegister() : void;
		
		function onRemove() : void;
		
		function get data() : IProxyVO;
		
		function set data(value : IProxyVO) : void;
	}
}
