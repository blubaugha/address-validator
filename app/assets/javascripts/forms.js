(function () {
    'use strict';

    $(addFormValidation);

    /** Adds validation to all forms on the page */
    function addFormValidation() {
        $("form.needs-validation").on("submit", function (e) {
            if (!this.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();

                // Focus the first invalid field so the user doesn't have to and can be lazy ;)
                $(this).find(':invalid').first().focus();
            }

            $(this).addClass('was-validated');
        });
    }
})();