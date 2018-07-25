/**
 * progressButton.js v1.0.0
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2013, Codrops
 * http://www.codrops.com
 */
;( function( window ) {
	
	'use strict';

	function extend( a, b ) {
		for( var key in b ) { 
			if( b.hasOwnProperty( key ) ) {
				a[key] = b[key];
			}
		}
		return a;
	}

	function ProgressButton( el, options ) {
		this.button = el;
		this.options = extend( {}, this.options );
  		extend( this.options, options );
  		this._init();
	}

	ProgressButton.prototype.options = {};

	ProgressButton.prototype._init = function() {
		// create structure
		this._create();
		// init events
		this._initEvents();
	};

	ProgressButton.prototype._create = function() {
		var $text = document.createElement('span');
			$text.className = 'btn-progress-text';
			$text.innerHTML = this.button.innerHTML;
		
		var $percent = document.createElement('span');
			$percent.className = 'btn-progress-percent';
			$percent.innerHTML = '0%';

		var $progressLine = document.createElement( 'span' );
			$progressLine.className = 'btn-progress-line';
			

		// clear content
		this.button.innerHTML = '';
		this.button.appendChild( $text );
		this.button.appendChild( $percent );
		this.button.appendChild( $progressLine );
		
		// the element that serves as the progress bar
		this.progress = $progressLine;
		this.percent = $percent;

		this._enable();
	};

	ProgressButton.prototype._setProgress = function( val ) {
		this.progress.style[ 'width' ] = val + '%';
		this.percent.innerHTML = val + '%';
	};

	ProgressButton.prototype._initEvents = function() {
		var self = this;
		this.button.addEventListener( 'click', function() {
			// disable the button
			self.button.setAttribute( 'disabled', '' );
			// add class state-loading to the button (applies a specific transform to the button depending which data-style is defined - defined in the stylesheets)
			this.classList.add('loading');

			self.options.callback(self);
		});
	};

	ProgressButton.prototype._stop = function( status ) {
		var self = this;

		self.progress.style[ 'width' ] = '100%';	
		self.percent.innerHTML = '100%';	
					
		setTimeout( function() {
			// fade out progress bar
			self.progress.style.opacity = 0;

			// add class state-success to the button
			if( typeof status === 'number' ) {
				var statusClass = status >= 0 ? 'success' : 'error';
				self.button.classList.add( statusClass );

				setTimeout( function() {
					self.button.classList.remove( statusClass );
					self._enable();
					self.progress.style.opacity = 1;
					self.progress.style[ 'width' ] = '0%';	
					self.percent.innerHTML = '0%';	
				}, 500 );
			}
			else {
				self._enable();
			}

			// remove class state-loading from the button
			self.button.classList.remove( 'loading' );
		}, 1500 );
	};

	// enable button
	ProgressButton.prototype._enable = function() {
		this.button.removeAttribute( 'disabled' );
	}

	// add to global namespace
	window.ProgressButton = ProgressButton;

})( window );