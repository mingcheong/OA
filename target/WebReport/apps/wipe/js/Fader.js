Fader = function(_) {
	this.element = _.element;
	this.elementID = _.elementID;
	this.style = _.style;
	this.num = _.num;
	this.maxMove = _.maxMove;
	this.finishNum = "string";
	this.interval = _.interval;
	this.onFinish = _.onFinish;
	this.isFinish = false;
	this.timer = null;
	this.method = this.num >= 0;
	this.baseMoveNum = _.baseMoveNum || 20;
	this.run = function() {
		clearInterval(this.timer);
		this.fade();
		if (this.isFinish) {
			if (this.onFinish)
				this.onFinish()
		} else {
			var $ = this;
			this.timer = setInterval(function() {
						$.run()
					}, this.interval)
		}
	};
	this.fade = function() {
		var _ = this.elementID ? $("#" + this.elementID) : this.element;
		if (this.finishNum == "string")
			this.finishNum = (parseInt(_.css(this.style)) || 0) + this.num;
		var A = parseInt(_.css(this.style)) || 0;
		if (this.finishNum > A && this.method) {
			A += this.baseMoveNum;
			if (A >= 0)
				this.finishNum = A = 0
		} else if (this.finishNum < A && !this.method) {
			A -= this.baseMoveNum;
			if ((A * -1) >= this.maxMove)
				this.finishNum = A = (this.maxMove * -1)
		}
		if ((this.finishNum <= A && this.method)
				|| (this.finishNum >= A && !this.method)) {
			_.css(this.style, this.finishNum + "px");
			this.isFinish = true;
			this.finishNum = "string"
		} else
			_.css(this.style, A + "px")
	}
}