data = [{'srno':'1',
         'name':'Chicken',
         'quant':700,
         'cost':9},
         {'srno':'2',
         'name':'Eggs',
         'quant':4200,
         'cost':3.50},
         {'srno':'3',
         'name':'Bread',
         'quant':24,
         'cost':4}]

shop_addresss = '234 234 st city, state, 12345'
shipping = 0
cart_total = 0

def print_menu():
    print('Sr.no     Item         Quantity     Cost/Item \n ------  ------      -----------     ----------')
    for i in data:
        print(f'   {i['srno']}     {i['name']}          {i['quant']}           {i['cost']}')

def get_item_request():
    item = input('What would you like to add/remove?')
    quant = get_quantity_request(item)
    #cart['items'].append(item)
    #cart['quantities'].append(quant)
    
    return item, quant

def get_quantity_request(item):
    quant = input(f'How many {item}?')
    for i in data:
        if i['srno'] == item:
            if i['quant'] < int(quant):
                print(f'Unfortunately, we only have{i['quant']} in stock.')
                return i['quant']
    return quant

def display_stock(item):
    for i in data:
        if i.srno == item:
            print(f'We have {i['quant']} {i['name']}(s) in stock.')

customers = [{'id':'1',
              'name':'John',
              'company':'chicken stack',
              'orders':{'nums':[1,2,3,4,5],
                        'todate':40000},
              'address':'42 12th st, ohio, 00000',
              'joined':'01-01-2020',
              'lastorder':'01-01-2023'
            }]

def get_distance(address):
    pass

def get_cust_info(id):
    for i in customers:
        if i['id'] == id:
            return i

def calc_shipping(id):
    for i in customers:
        if i['id'] == id:
            #distance = get_distance(i['address'])
            distance = 20 #placeholder value
            if distance >= 15 and distance <=30:
                return 100
            elif distance <15:
                return 50
    #<15km = 50
    #>=15<=30km = 100
    pass

def display_bill_info():
    pass

def dist_conversion(val,to_mi=True):
    if to_mi:
        return val/1.609344
    else:
        return val*1.690344
    pass

def return_or_quit():
    menuChoice =input('press "q" to quit or "r" to return to the main menu.')
    if menuChoice == 'r':
        main()
    elif menuChoice == 'q':
        print('Thank you. See you next time!')
    else:
        print('invalid menu option, please restart the program.')

def display_cart():
    print(f'items     quantities\n ========     ====\n{cart['items']} {cart['quantities']}')

cart = {"items":[],
        "quantities":[]}


def main():
    print_menu()
    id = input('Welcome to magic store fun arena.. Enter your customer id')
    shipping = calc_shipping(id)

    selection = input('What would you like to do:\n press 1 to display customer info\n press 2 to update your info\n press 3 to add and item to your cart\n press 4 to remove an item from your cart\n press 5 to checkout and display your info\n press 6 to display cart')
    if selection == '1':
        #display customer info
        customerinfo = get_cust_info(id)
        print(customerinfo)
        return_or_quit()
    elif selection =='2':
        #update customer info
        customerinfo = get_cust_info(id)
        update_selection = input('What would you like to update:\npress 1 for company\n press 2 for address')
        if update_selection == '1':
            newcompany = input('please enter the new info.')
            customerinfo['company'] = newcompany
        elif update_selection == '2':
            newaddress = input('please enter the new info.')
            customerinfo['address'] = newaddress
        print(customerinfo)
        return_or_quit()
    elif selection =='3':
        #place a new order
        citem,cquant = get_item_request()
        cart['items'].append(citem)
        cart['quantities'].append(cquant)

        return_or_quit()
    elif selection =='4':
        #remove item from cart
        citem,cquant = get_item_request()
        for i,el in enumerate(cart['items']):
            if cart['items'][i] == citem and int(cquant) <= int(cart['quantities'][i]):
                #wip
                if int(cquant) == int(cart['quantities'][i]):
                    cart['items'].remove(citem)
                    del cart['quantities'][i]
                else:
                    cart['quantities'][i] = str(int(cart['quantities'][i]) - int(cquant))
        display_cart()
        return_or_quit()
    elif selection =='5':
        #checkout and display customer info
        return_or_quit()
    elif selection =='6':
        display_cart()
        return_or_quit()
    else:
        print('invalid menu selection')

main()