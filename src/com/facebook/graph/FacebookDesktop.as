﻿/*
  import com.facebook.graph.data.FacebookSession;
  import com.facebook.graph.windows.LoginWindow;

	public static function set locale(value:String):void {
		getInstance().locale = value;
	}

     * The handler must have the signature of callback(result:Object, fail:Object);
	/**
     * Returns a reference to the entire raw object
	 * Facebook returns (including paging, etc.).
     *
     * @param data The result object.
     *
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function getRawResult(data:Object):Object {			
		return getInstance().getRawResult(data);
	}
	
	/**
     * Asks if another page exists
	 * after this result object.
     *
     * @param data The result object.
     *
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function hasNext(data:Object):Boolean {
		var result:Object = getInstance().getRawResult(data);
		if(!result.paging){ return false; }
		return (result.paging.next != null);
	}
	
	/**
     * Asks if a page exists
	 * before this result object.
     *
     * @param data The result object.
     *
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function hasPrevious(data:Object):Boolean {
		var result:Object = getInstance().getRawResult(data);
		if(!result.paging){ return false; }
		return (result.paging.previous != null);
	}
	
	/**
     * Retrieves the next page that is associated with result object passed in.
     *
     * @param data The result object.
	 * @param callback Method that will be called when this request is complete
     * The handler must have the signature of callback(result:Object, fail:Object);
     * On success, result will be the object data returned from Facebook.
     * On fail, result will be null and fail will contain information about the error.
	 * 
	 * @see com.facebook.graph.net.FacebookDesktop#request()
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function nextPage(data:Object, callback:Function):void {
		getInstance().nextPage(data, callback);
	}
	
	/**
     * Retrieves the previous page that is associated with result object passed in.
     *
     * @param data The result object.
	 * @param callback Method that will be called when this request is complete
     * The handler must have the signature of callback(result:Object, fail:Object);
     * On success, result will be the object data returned from Facebook.
     * On fail, result will be null and fail will contain information about the error.
     *
	 * @see com.facebook.graph.net.FacebookDesktop#request()
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function previousPage(data:Object, callback:Function):void {
		getInstance().previousPage(data, callback);
	}

	 * Executes an FQL query on api.facebook.com.
	 * 
	 * @param query The FQL query string to execute.
	 * @param values Replaces string values in the in the query. 
	 * ie. Replaces {digit} or {id} with the corresponding key-value in the values object 
	 * @see http://developers.facebook.com/docs/reference/fql/
	 * @see com.facebook.graph.net.Facebook#callRestAPI()
	 * 
	 */	
	public static function fqlQuery(query:String, callback:Function=null, values:Object=null):void {
		getInstance().fqlQuery(query, callback, values);
	}
	
	/**
	 * Executes an FQL multiquery on api.facebook.com.
	 * 
	 * @param queries FQLMultiQuery The FQL queries to execute.
	 * @param parser IResultParser The parser used to parse result into object of name/value pairs. 
	 * @see http://developers.facebook.com/docs/reference/fql/
	 * @see com.facebook.graph.net.Facebook#callRestAPI()
	 * 
	 */	
	public static function fqlMultiQuery(queries:FQLMultiQuery, callback:Function=null, parser:IResultParser=null):void {
		getInstance().fqlMultiQuery(queries, callback, parser);
	}
