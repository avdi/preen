Feature: User preens
  As a karma whore
  I want to spam my friends when I show up on reddit
  So that they will rate me up

  Scenario: initialize preen
  Given this is the first time I have run preen
   When I run "preen init --pingfm-key 1234 --url-pattern http://johndoe.example.com/"
    And preen should remember that my Ping.fm Key is 1234
    And preen should remember that my URL Pattern is http:\/\/johndoe\.example\.com\/

  Scenario: run preen
  Given that I have initialized preen
    And reddit is serving the following pages:
      |path            |file             |
      |/               |reddit_page1.html|
      |/page2          |reddit_page2.html|
      |/page3          |reddit_page3.html|
      |/page4          |reddit_page4.html|
   When I run "preen scan"
   Then preen should scan the Reddit path "/"
    And preen should scan the Reddit path "/page2"
    And preen should scan the Reddit path "/page3"
    But preen should not scan the Reddit path "/page4" 
    And preen should announce "/john_doe_article_1" on Ping.fm
    And preen should announce "/john_doe_article_2" on Ping.fm
    But preen should not announce "/john_doe_article_3" on Ping.fm

  Scenario: run preen again
  Given that I have initialized preen
    And reddit is serving the following pages:
      |path            |file             |
      |/               |reddit_page1.html|
      |/page2          |reddit_page2.html|
      |/page3          |reddit_page3.html|
      |/page4          |reddit_page4.html|
    And I have run "preen scan" once already
   Then preen should not announce any articles on Ping.fm

