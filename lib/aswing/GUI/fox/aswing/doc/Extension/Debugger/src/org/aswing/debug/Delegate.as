/*
 * Copyright (c) 2005, xlands.com inc.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * 1) Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *  
 * 2) Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution. 
 * 
 * 3) Neither the name of xlands.com inc. nor the names of its contributors may be used
 *    to endorse or promote products derived from this software without specific
 *    prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
 * POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * Mtasc compileable Delegate class. */
class org.aswing.debug.Delegate{


	
	private var func:Function;
	/**
	 *Creates a functions wrapper for the original function so that it runs 
	 *in the provided context.
	 *@param obj Context in which to run the function.
	 *@param func Function to run. you can add custom parameters after this to be the 
	 *additional parameters when called the created function.
	 */
	static function create(obj:Object, func:Function):Function
	{
		
		  var params:Array = new Array();
		  var count:Number=2;
		  while(count<arguments.length){
		  	params[ count-2] = arguments[count];
		  	count++;
		  }
		  
		
		var f:Function = function()
		{
			var target:Object = arguments.callee.target;
			var func0:Function = arguments.callee.func;
            var parameters:Array = arguments.concat(params);
			return func0.apply(target, parameters);
		};

		f.target = obj;
		f.func = func;

		return f;
	}

	function Delegate(f:Function)
	{
		func = f;
	}

	

	public function createDelegate(obj:Object):Function
	{
		return create(obj, func);
	}	
}