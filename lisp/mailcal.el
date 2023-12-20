(provide 'mailcal)
;; Set up bbdb
(require 'bbdb)
(bbdb-initialize 'message)
(bbdb-insinuate-message)
(add-hook 'message-setup-hook 'bbdb-insinuate-mail)
;; set up calendar
(require 'calfw)
(require 'calfw-ical)
;; Set this to the URL of your calendar. Google users will use
;; the Secret Address in iCalendar Format from the calendar settings
(cfw:open-ical-calendar "https://path/to/my/ics/file.ics")
;; Set up notmuch
(require 'notmuch)
;; set up mail sending using sendmail
(setq send-mail-function (quote sendmail-send-it))
(setq user-mail-address "ajinkya@poetictechnologies.com"
      user-full-name "Ajinkya Kulkarni")
