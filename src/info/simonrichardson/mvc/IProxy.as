package info.simonrichardson.mvc
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IProxy extends ISignalMap
	{
				
		function onRegister() : void;
		
		function onRemove() : void;
		
		function get data() : IProxyVO;
		
		function set data(value : IProxyVO) : void;
	}
}
