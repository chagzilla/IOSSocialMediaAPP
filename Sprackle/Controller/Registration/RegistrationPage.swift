//
//  RegistrationPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/11/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class RegistrationPage: UIViewController {
    var navigation: AppNavigationController?
    
    var count = 0
    var data:[String: String] = [:]
    var boolList = Array(repeating: false, count: 6)
    var images = [UIImage]()
    var skillPicked = false
    
    //page Text
    let SprackleLabel: UILabel = {
        let l = UILabel()
        l.text = "Sprackle"
        l.font = l.font.withSize(30)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    let GoalLabel: UILabel = {
        let l = UILabel()
        l.text = "Organizing the freestyle world"
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        
        return l
    }()
    let StepLabel: UILabel = {
        let l = UILabel()
        l.text = "Step 2: For Connecting"
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    let AttributeLabel: UILabel = {
        let l = UILabel()
        l.text = "Attributes"
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    //selected Attributes
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let attributeOne: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        return image
    }()
    
    let attributeTwo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        return image
    }()
    
    let attributeThree: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        return image
    }()
    
    
    //Attributes
    let NoobButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setBackgroundImage(UIImage(named: "Noob"), for: .normal)
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 16
        b.addTarget(self, action: #selector(pressedNoob), for: .touchUpInside)
        
        return b
    }()
    let NoobLabel: UILabel = {
        let l = UILabel()
        l.text = "Noob"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    let ParkButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setBackgroundImage(UIImage(named: "Park"), for: .normal)
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 16
        b.addTarget(self, action: #selector(pressedPark), for: .touchUpInside)
       
        return b
    }()
    let ParkLabel: UILabel = {
        let l = UILabel()
        l.text = "Park"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    let SendItButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setBackgroundImage(UIImage(named: "Sender"), for: .normal)
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 16
        b.addTarget(self, action: #selector(pressedSender), for: .touchUpInside)
        
        return b
    }()
    let SendItLabel: UILabel = {
        let l = UILabel()
        l.text = "Send It"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let StreetButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setBackgroundImage(UIImage(named: "Street"), for: .normal)
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 16
        b.addTarget(self, action: #selector(pressedStreet), for: .touchUpInside)
        return b
    }()
    let StreetLabel: UILabel = {
        let l = UILabel()
        l.text = "Street"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let FilmerButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setBackgroundImage(UIImage(named: "Behind The Lens"), for: .normal)
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 16
        b.addTarget(self, action: #selector(pressedLens), for: .touchUpInside)
        
        return b
    }()
    let FilmerLabel: UILabel = {
        let l = UILabel()
        l.text = "Filmer"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let TechButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setBackgroundImage(UIImage(named: "Tech as Heck"), for: .normal)
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 16
        b.addTarget(self, action: #selector(pressedTech), for: .touchUpInside)
        return b
    }()
    let TechLabel: UILabel = {
        let l = UILabel()
        l.text = "Tech"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    //your sports
    let TwoFeetButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(twoFeet(_:)), for: .touchUpInside)
        return b
    }()
    let TwoWheelsButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(two(_:)), for: .touchUpInside)
        return b
    }()
    let FourWheelsButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(four(_:)), for: .touchUpInside)
        return b
    }()
    
    let NextButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.gray
        b.setTitle("Next", for: .normal)
        b.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addToView()
        setupText()
        setupButtons()
        setupLabels()
        setupPicContainer()
        setupSkillButtons()
        setupNextButton()
        // Do any additional setup after loading the view.
    }
    
    @objc func handleNext() {
        if images.count == 3 && skillPicked {
            let ProfileSetup = SetupProfilePage()
            updateData()
            ProfileSetup.navigation = self.navigation
            ProfileSetup.data = data
            self.dismiss(animated: true, completion: {
                self.navigation?.present(ProfileSetup, animated: true, completion: nil)
            })
        } else {
            alertTheUser(title: "Pick Attributes", message: "Finish Picking your attributes!")
        }
        
    }
    
    func addToView() {
        //adding the text
        view.addSubview(SprackleLabel)
        view.addSubview(GoalLabel)
        view.addSubview(StepLabel)
        view.addSubview(AttributeLabel)
        view.addSubview(inputsContainerView)
        
        //adding to the inputsContainer
        inputsContainerView.addSubview(attributeOne)
        inputsContainerView.addSubview(attributeTwo)
        inputsContainerView.addSubview(attributeThree)
        
        //adding the buttons to the screen
        view.addSubview(NoobButton)
        view.addSubview(ParkButton)
        view.addSubview(SendItButton)
        view.addSubview(StreetButton)
        view.addSubview(FilmerButton)
        view.addSubview(TechButton)
        
        //adding the labels to the screen
        view.addSubview(NoobLabel)
        view.addSubview(ParkLabel)
        view.addSubview(SendItLabel)
        view.addSubview(StreetLabel)
        view.addSubview(FilmerLabel)
        view.addSubview(TechLabel)
        
        //adding the skill buttons to the screen
        view.addSubview(TwoWheelsButton)
        view.addSubview(TwoFeetButton)
        view.addSubview(FourWheelsButton)
        
        //adding the next screen button to the screen
        view.addSubview(NextButton)
        
        
    }
    
    func setupText() {
        SprackleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SprackleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        SprackleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        SprackleLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        
        GoalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        GoalLabel.topAnchor.constraint(equalTo: SprackleLabel.bottomAnchor).isActive = true
        GoalLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        GoalLabel.heightAnchor.constraint(equalToConstant:25).isActive = true
        
        StepLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        StepLabel.topAnchor.constraint(equalTo: GoalLabel.bottomAnchor).isActive = true
        StepLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        StepLabel.heightAnchor.constraint(equalToConstant:25).isActive = true
        
        AttributeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AttributeLabel.topAnchor.constraint(equalTo: StepLabel.bottomAnchor, constant: 50).isActive = true
        AttributeLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        AttributeLabel.heightAnchor.constraint(equalToConstant:25).isActive = true
        
        
        
    }
    
    func setupPicContainer() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: AttributeLabel.bottomAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        attributeOne.rightAnchor.constraint(equalTo: attributeTwo.leftAnchor, constant: -10).isActive = true
        attributeOne.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        attributeOne.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, constant: -40).isActive = true
        attributeOne.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/4).isActive = true
        
        attributeTwo.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        attributeTwo.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        attributeTwo.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, constant: -40).isActive = true
        attributeTwo.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/4).isActive = true
        
        attributeThree.leftAnchor.constraint(equalTo: attributeTwo.rightAnchor, constant: 10).isActive = true
        attributeThree.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        attributeThree.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, constant: -40).isActive = true
        attributeThree.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/4).isActive = true
        
    }
    
    func setupButtons() {
        
        
        
        NoobButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        NoobButton.rightAnchor.constraint(equalTo: ParkButton.leftAnchor, constant: -10).isActive = true
        NoobButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8).isActive = true
        NoobButton.widthAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        
        ParkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ParkButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        ParkButton.heightAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        ParkButton.widthAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        
        SendItButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        SendItButton.leftAnchor.constraint(equalTo: ParkButton.rightAnchor, constant: 10).isActive = true
        SendItButton.heightAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        SendItButton.widthAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        
        StreetButton.centerXAnchor.constraint(equalTo: NoobButton.centerXAnchor).isActive = true
        StreetButton.topAnchor.constraint(equalTo: NoobLabel.bottomAnchor, constant: 10).isActive = true
        StreetButton.heightAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        StreetButton.widthAnchor.constraint(equalTo: NoobButton.widthAnchor).isActive = true
        
        FilmerButton.centerXAnchor.constraint(equalTo: ParkButton.centerXAnchor).isActive = true
        FilmerButton.topAnchor.constraint(equalTo: ParkLabel.bottomAnchor, constant: 10).isActive = true
        FilmerButton.heightAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        FilmerButton.widthAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        
        TechButton.centerXAnchor.constraint(equalTo: SendItButton.centerXAnchor).isActive = true
        TechButton.topAnchor.constraint(equalTo: SendItLabel.bottomAnchor, constant: 10).isActive = true
        TechButton.widthAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        TechButton.heightAnchor.constraint(equalTo: NoobButton.heightAnchor).isActive = true
        
    }
    
    func setupLabels() {
        
        
        NoobLabel.centerXAnchor.constraint(equalTo: NoobButton.centerXAnchor).isActive = true
        NoobLabel.topAnchor.constraint(equalTo: NoobButton.bottomAnchor).isActive = true
        
        ParkLabel.centerXAnchor.constraint(equalTo: ParkButton.centerXAnchor).isActive = true
        ParkLabel.topAnchor.constraint(equalTo: ParkButton.bottomAnchor).isActive = true
        
        SendItLabel.centerXAnchor.constraint(equalTo: SendItButton.centerXAnchor).isActive = true
        SendItLabel.topAnchor.constraint(equalTo: SendItButton.bottomAnchor).isActive = true
        
        StreetLabel.centerXAnchor.constraint(equalTo: StreetButton.centerXAnchor).isActive = true
        StreetLabel.topAnchor.constraint(equalTo: StreetButton.bottomAnchor).isActive = true
        
        FilmerLabel.centerXAnchor.constraint(equalTo: FilmerButton.centerXAnchor).isActive = true
        FilmerLabel.topAnchor.constraint(equalTo: FilmerButton.bottomAnchor).isActive = true
        
        TechLabel.centerXAnchor.constraint(equalTo: TechButton.centerXAnchor).isActive = true
        TechLabel.topAnchor.constraint(equalTo: TechButton.bottomAnchor).isActive = true
    }
    
    func setupSkillButtons(){
        
        
        TwoFeetButton.centerYAnchor.constraint(equalTo: TwoWheelsButton.centerYAnchor).isActive = true
        TwoFeetButton.rightAnchor.constraint(equalTo: TwoWheelsButton.leftAnchor, constant: -10).isActive = true
        TwoFeetButton.heightAnchor.constraint(equalTo: TwoWheelsButton.heightAnchor).isActive = true
        TwoFeetButton.widthAnchor.constraint(equalTo: TwoWheelsButton.widthAnchor).isActive = true
        
        TwoWheelsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TwoWheelsButton.topAnchor.constraint(equalTo: FilmerLabel.bottomAnchor, constant: 10 ).isActive = true
        TwoWheelsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TwoWheelsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        FourWheelsButton.centerYAnchor.constraint(equalTo: TwoWheelsButton.centerYAnchor).isActive = true
        FourWheelsButton.leftAnchor.constraint(equalTo: TwoWheelsButton.rightAnchor, constant: 10).isActive = true
        FourWheelsButton.heightAnchor.constraint(equalTo: TwoWheelsButton.heightAnchor).isActive = true
        FourWheelsButton.widthAnchor.constraint(equalTo: TwoWheelsButton.widthAnchor).isActive = true
        
        
    }
    
    func setupNextButton() {
        NextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NextButton.topAnchor.constraint(equalTo:  TwoWheelsButton.bottomAnchor, constant: 10).isActive = true
        NextButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        NextButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func updatearrays(abool: Bool, image: UIImage, index: Int){
        
        if avalibleSpot() && !abool
        {
            images.append(image)
            
        }
        else if let index = images.index(of: image)
        {
            images.remove(at: index)
            
        }
        boolList[index] = !abool
    }
    
    func avalibleSpot() -> Bool
    {
        if images.count < 3
        {return true}
        else
        {return false}
    }
    
    func updateImages() {
        if images.count == 3
        {
            attributeOne.image = images[0]
            attributeTwo.image = images[1]
            attributeThree.image = images[2]
            
        }
        if images.count == 2
        {
            attributeOne.image = images[0]
            attributeTwo.image = images[1]
            attributeThree.image = nil
            
        }
        if images.count == 1
        {
            attributeOne.image = images[0]
            attributeTwo.image = nil
            attributeThree.image = nil
        }
        if images.count == 0
        {
            attributeOne.image = nil
            attributeTwo.image = nil
            attributeThree.image = nil
            
        }
    }
    
    func updateData() {
        var x = 0
        for image in images    {
            
            if image.isEqual(#imageLiteral(resourceName: "Noob")){
                switch x {
                case 0:
                    data["AONE"] = "noob"
                case 1:
                    data["ATWO"] = "noob"
                default:
                    data["ATHREE"] = "noob"
                }
                x += 1
                
            }
            if image.isEqual(#imageLiteral(resourceName: "Park")){
                switch x {
                case 0:
                    data["AONE"] = "park"
                case 1:
                    data["ATWO"] = "park"
                default:
                    data["ATHREE"] = "park"
                }
                x += 1
            }
            if image.isEqual(#imageLiteral(resourceName: "Sender")){
                switch x {
                case 0:
                    data["AONE"] = "sender"
                case 1:
                    data["ATWO"] = "sender"
                default:
                    data["ATHREE"] = "sender"
                }
                x += 1
            }
            if image.isEqual(#imageLiteral(resourceName: "Street")){
                switch x {
                case 0:
                    data["AONE"] = "street"
                case 1:
                    data["ATWO"] = "street"
                default:
                    data["ATHREE"] = "street"
                }
                x += 1
            }
            if image.isEqual(#imageLiteral(resourceName: "Behind The Lens")){
                switch x {
                case 0:
                    data["AONE"] = "lens"
                case 1:
                    data["ATWO"] = "lens"
                default:
                    data["ATHREE"] = "lens"
                }
                x += 1
            }
            if image.isEqual(#imageLiteral(resourceName: "Tech as Heck")){
                switch x {
                case 0:
                    data["AONE"] = "tech"
                case 1:
                    data["ATWO"] = "tech"
                default:
                    data["ATHREE"] = "tech"
                }
                x += 1
            }
            
        }
    }
    
    @objc func pressedNoob(_ sender: Any) {
        updatearrays(abool: boolList[0], image: #imageLiteral(resourceName: "Noob"), index: 0)
        updateImages()
        
    }
    
    @objc func pressedPark(_ sender: Any) {
        updatearrays(abool: boolList[1], image: #imageLiteral(resourceName: "Park"), index: 1)
        updateImages()
    }
    
    @objc func pressedSender(_ sender: Any) {
        updatearrays(abool: boolList[2], image: #imageLiteral(resourceName: "Sender"), index: 2)
        updateImages()
        
    }
    
    @objc func pressedStreet(_ sender: Any) {
        updatearrays(abool: boolList[3], image: #imageLiteral(resourceName: "Street"), index: 3)
        updateImages()
        
    }
    
    @objc func pressedLens(_ sender: Any) {
        updatearrays(abool: boolList[4], image: #imageLiteral(resourceName: "Behind The Lens"), index: 4)
        updateImages()
    }
    
    @objc func pressedTech(_ sender: Any) {
        updatearrays(abool: boolList[5], image: #imageLiteral(resourceName: "Tech as Heck"), index: 5)
        updateImages()
    }
    
    @objc func twoFeet(_ sender: Any) {
        self.TwoFeetButton.backgroundColor = UIColor.lightGray
        self.TwoWheelsButton.backgroundColor = UIColor.white
        self.FourWheelsButton.backgroundColor = UIColor.white
        self.data["SKILL"] = "twoFeet"
        self.skillPicked = true
        
    }
    
    @objc func two(_ sender: Any) {
        self.TwoWheelsButton.backgroundColor = UIColor.lightGray
        self.TwoFeetButton.backgroundColor = UIColor.white
        self.FourWheelsButton.backgroundColor = UIColor.white
        self.data["SKILL"] = "twoWheels"
        self.skillPicked = true
    }
    
    @objc func four(_ sender: Any) {
        self.FourWheelsButton.backgroundColor = UIColor.lightGray
        self.TwoFeetButton.backgroundColor = UIColor.white
        self.TwoWheelsButton.backgroundColor = UIColor.white
        self.data["SKILL"] = "fourWheels"
        self.skillPicked = true
    }
    
    private func alertTheUser(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
