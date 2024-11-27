@mod @mod_choicegroup
Feature: Use the choicegroup activity using groups within groupings
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
      | E    | C1     | C1G5     | Group E     |
      | F    | C1     | C1G6     | Group F     |
    And the following "groupings" exist:
      | name | course | idnumber | description |
      | X    | C1     | GG1      | Grouping X  |
      | Y    | C1     | GG2      | Grouping Y  |
      | Z    | C1     | GG3      | Grouping Z  |
    And the following "grouping groups" exist:
      | grouping | group |
      | GG1      | C1G1  |
      | GG1      | C1G2  |
      | GG1      | C1G3  |
      | GG1      | C1G4  |
      | GG1      | C1G5  |
      | GG1      | C1G6  |
      | GG2      | C1G1  |
      | GG2      | C1G2  |
      | GG2      | C1G3  |
      | GG3      | C1G4  |
      | GG3      | C1G5  |
      | GG3      | C1G6  |
    And the following "activities" exist:
      | activity    | name           | intro                      | course | idnumber     |
      | choicegroup | Group choice 1 | Group choice 1 for testing | C1     | choicegroup1 |

  @javascript
  Scenario: View a choicegroup activity with groups within groupings
    Given I am on the "Group choice 1" "choicegroup activity editing" page logged in as teacher1
    And I press "Expand All Groupings"
    And I should see "X"
    And I should see "Y"
    And I set the field "availablegroups" to "X"
    And I press "Add Grouping"
    And I press "Save and return to course"
    # Reopen the choicegroup activity.
    And I am on the "Group choice 1" "choicegroup activity editing" page logged in as teacher1
    Then "//*[@id='id_selectedGroups']" "xpath_element" should exist
    And "((//*[@id='id_selectedGroups'])/*)[1]" "xpath_element" should exist
    But "((//*[@id='id_selectedGroups'])/*)[8]" "xpath_element" should not exist
