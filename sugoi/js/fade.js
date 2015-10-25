(function() {

    var quotes = $(".quotes");
    var quoteIndex = -1;
    
    function showNextQuote() {
        ++quoteIndex;
        quotes.eq(quoteIndex % quotes.length)
            quotes.fadeIn(2000);
    }
    
    showNextQuote();
    
})();