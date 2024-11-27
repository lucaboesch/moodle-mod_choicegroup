@mod @mod_choicegroup
Feature: Use the choicegroup activity with groups within groupings
  In order to use choicegroup in a course with groupings
  As a teacher
  I need to be assured choicegroup behaves correctly

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | student1 | Vinnie    | Student1 | student1@example.com |
      | student2 | Ann       | Student2 | student2@example.com |
      | teacher1 | Darrell   | Teacher1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | student1 | C1     | student        |
      | student2 | C1     | student        |
      | teacher1 | C1     | editingteacher |
    And the following "groups" exist:
      | name | course | idnumber | description |
      | A    | C1     | C1G1     | Group A     |
      | B    | C1     | C1G2     | Group B     |
      | C    | C1     | C1G3     | Group C     |
      | D    | C1     | C1G4     | Group D     |
    And the following "groupings" exist:
      | name | course | idnumber | description |
      | X    | C1     | GG1      | Grouping X  |
      | Y    | C1     | GG2      | Grouping Y  |
    And the following "grouping groups" exist:
      | grouping | group |
      | GG1      | C1G1  |
      | GG1      | C1G2  |
      | GG2      | C1G1  |

  @javascript
  Scenario: View a choicegroup activity with groups within groupings
    Given I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    And I press "Add an activity or resource"
    And I click on "Add a new Group choice" "link" in the "Add an activity or resource" "dialogue"
    And I set the following fields to these values:
      | Group choice name | Choose your group        |
      | Description       | Group choice description |
    And I press "Expand All Groupings"
    And I should see "X"
    And I should see "Y"
    And I set the field "availablegroups" to "A"
    And I press "Add Group"
    And I press "Save and return to course"
    # Student view.
    And I am on the "Choose your group" "choicegroup activity" page logged in as student1
    And I click on "A" "radio"
    And I press "Save my choice"
    And I log out
    # Teacher view.
    And I am on the "Choose your group" "choicegroup activity" page logged in as teacher1
    And I navigate to "Settings" in current page administration
    And I am on the "Choose your group" "choicegroup activity" page logged in as teacher1
    And ".choicegroups tbody tr:nth-of-type(2)" "css_element" should be visible
    And ".choicegroups tbody tr:nth-of-type(3)" "css_element" should be visible

