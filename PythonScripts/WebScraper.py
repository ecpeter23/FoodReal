from bs4 import BeautifulSoup
from datetime import date
import requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from enum import Enum


class Time(Enum):
    BREAKFAST = 1
    LUNCH = 2
    DINNER = 3


# Splits the menu to its individual sections based on the time
def split_menu(menu: BeautifulSoup, time: Time):
    menu_sections = menu.findAll(class_="bite-menu-item")
    if time == Time.BREAKFAST:
        return menu_sections[0], menu_sections[1], menu_sections[2], menu_sections[3], menu_sections[4], menu_sections[
            5]
    return (menu_sections[0], menu_sections[1], menu_sections[2], menu_sections[3], menu_sections[4], menu_sections[5],
            menu_sections[6], menu_sections[7], menu_sections[8], menu_sections[9])


def extract_food_items(section: BeautifulSoup):
    food_items = []
    for item in section.find_all('a', attrs={'data-fooditemname': True}):
        food_items.append(item['data-fooditemname'])
    return food_items


# URL of the target website (Rathbone Dining Hall Menu)
URL = "https://menus.sodexomyway.com/BiteMenu/Menu?menuId=16872&locationId=97451005&whereami=http://lehigh.sodexomyway.com/dining-near-me/rathbone"

# Gets the webpage
response = requests.get(URL)

# Gets the HTML of the response
page_content = BeautifulSoup(response.content, "html.parser")

# The current menu to search for in the HTML (for example on the 15th it would be 'menuid-15-day' it changes each day)
current_menu_id = f'menuid-{date.today().day}-day'
# print(current_menu_id)

# Gets the HTML content
menu = page_content.find(id=current_menu_id)

# Breakfast HTML
menu_breakfast = menu.find(class_="accordion-block breakfast").find(class_="accordion-panel rtf hide")
menu_breakfast = split_menu(menu_breakfast, Time.BREAKFAST)

# Lunch HTML
menu_lunch = menu.find(class_="accordion-block lunch").find(class_="accordion-panel rtf hide")
menu_lunch = split_menu(menu_lunch, Time.LUNCH)

# Dinner HTML
menu_dinner = menu.find(class_="accordion-block dinner").find(class_="accordion-panel rtf hide")
menu_dinner = split_menu(menu_dinner, Time.DINNER)


# Extract food items for breakfast
class Breakfast:
    DINER = extract_food_items(menu_breakfast[0])
    HOMETOWN = extract_food_items(menu_breakfast[1])
    MISCELLANEOUS = extract_food_items(menu_breakfast[2])
    MTO_EGGS = extract_food_items(menu_breakfast[3])
    SIMPLE_SERVINGS = extract_food_items(menu_breakfast[4])
    SOUPS = extract_food_items(menu_breakfast[5])


# Extract food items for breakfast
class Lunch:
    DINER = extract_food_items(menu_lunch[0])
    GLOWBOWL_MTO = extract_food_items(menu_lunch[1])
    HOMETOWN = extract_food_items(menu_lunch[2])
    MISCELLANEOUS = extract_food_items(menu_lunch[3])
    MTO_EGGS = extract_food_items(menu_lunch[4])
    PASTA = extract_food_items(menu_lunch[5])
    PIZZA = extract_food_items(menu_lunch[6])
    SIMPLE_SERVINGS = extract_food_items(menu_lunch[7])
    SOUPS = extract_food_items(menu_lunch[8])
    VEG_OUT = extract_food_items(menu_lunch[9])


# Extract food items for breakfast
class Dinner:
    DINER = extract_food_items(menu_dinner[0])
    GLOWBOWL_MTO = extract_food_items(menu_dinner[1])
    HOMETOWN = extract_food_items(menu_dinner[2])
    MISCELLANEOUS = extract_food_items(menu_dinner[3])
    MTO_EGGS = extract_food_items(menu_dinner[4])
    PASTA = extract_food_items(menu_dinner[5])
    PIZZA = extract_food_items(menu_dinner[6])
    SIMPLE_SERVINGS = extract_food_items(menu_dinner[7])
    SOUPS = extract_food_items(menu_dinner[8])
    VEG_OUT = extract_food_items(menu_dinner[9])


#  print(Lunch.PASTA)
#  print(Lunch.SIMPLE_SERVINGS)

data = {
    "Breakfast": {
        "DINER": Breakfast.DINER,
        "HOMETOWN": Breakfast.HOMETOWN,
        "MISCELLANEOUS": Breakfast.MISCELLANEOUS,
        "MTO_EGGS": Breakfast.MTO_EGGS,
        "SIMPLE_SERVINGS": Breakfast.SIMPLE_SERVINGS,
        "SOUPS": Breakfast.SOUPS
    },
    "Lunch": {
        "DINER": Lunch.DINER,
        "GLOWBOWL_MTO": Lunch.GLOWBOWL_MTO,
        "HOMETOWN": Lunch.HOMETOWN,
        "MISCELLANEOUS": Lunch.MISCELLANEOUS,
        "MTO_EGGS": Lunch.MTO_EGGS,
        "PASTA": Lunch.PASTA,
        "PIZZA": Lunch.PIZZA,
        "SIMPLE_SERVINGS": Lunch.SIMPLE_SERVINGS,
        "SOUPS": Lunch.SOUPS,
        "VEG_OUT": Lunch.VEG_OUT
    },
    "Dinner": {
        "DINER": Dinner.DINER,
        "GLOWBOWL_MTO": Dinner.GLOWBOWL_MTO,
        "HOMETOWN": Dinner.HOMETOWN,
        "MISCELLANEOUS": Dinner.MISCELLANEOUS,
        "MTO_EGGS": Dinner.MTO_EGGS,
        "PASTA": Dinner.PASTA,
        "PIZZA": Dinner.PIZZA,
        "SIMPLE_SERVINGS": Dinner.SIMPLE_SERVINGS,
        "SOUPS": Dinner.SOUPS,
        "VEG_OUT": Dinner.VEG_OUT
    }
}

cred = credentials.Certificate("path/to/serviceAccountKey.json")
firebase_admin.initialize_app(cred)


print(data)
