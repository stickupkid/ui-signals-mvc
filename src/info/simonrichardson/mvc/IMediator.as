package info.simonrichardson.mvc
{
	import info.simonrichardson.ui.display.UISprite;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public interface IMediator extends ISignalMap
	{

		function listSignalHooks() : Vector.<IHook>;

		function onRegister() : void;

		function onRemove() : void;

		function get viewComponent() : UISprite;

		function set viewComponent(value : UISprite) : void;
	}
}
