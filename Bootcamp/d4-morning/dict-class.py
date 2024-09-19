

dict_test  = {"Dogs": "retreiver"}


dict_animals = {
                'Dogs': "test",
                "Cats" : ["Fluffy Orange Cat with One Braincell", "Short Hair", "Calico"],
                "This is an int": 42,
                "This is a float": 1.17
                }

dict_animals['This is a f-string'] = f"I want to see if this outputs 1.17: {dict_animals['This is a float']}"

class Dog:
    def __init__(self,species):
        self.species = species
    def whattype(self):
        print(f"I am a {self.species}")

Shorthair = Dog("Shorthair")

Shorthair.whattype()

def dont_make_me_use_r():
    print("I dont want to go back to R this afternoon")
    

dict_animals["dog type"] = Shorthair
dict_animals["wailing cry"] = dont_make_me_use_r()






s = "it was the best of times it was the worst of times"




words = {test: s.count(test) for test in s}
# for i in range(len(s)):
#     if s[i] not in words:
#         words[s[i]] = 1
#         continue
#     words[s[i]] += 1

print(words)


# TIL about dictionary comphrehension
s1 = "it was the best of times it was the worst of times"
s1 = s1.split(" ")

words1 = {word: s1.count(word) for word in s1}
print(words1)


