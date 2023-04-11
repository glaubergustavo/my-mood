//
//  Constants.swift
//  MyMood
//
//  Created by Glauber Gustavo on 30/03/23.
//

class Constants {
    
    struct API {
        static let BaseURL = "https://firebasestorage.googleapis.com/v0/b/nasa-api-tests.appspot.com/o/getArchiteture.json?alt=media&token=d19d1bb5-82b3-43a5-a440-1bf8ef6dfd08"
    }
    
    struct Messages {
        static let Empty = ""
        static let ChooseMood = "Escolha seu humor"
        static let MyMood = "Meu Humor"
        static let Thanks = "Obrigado!"
        static let SeeDataMood = "Veja seus dados do humor"
        static let Exit = "Sair"
        static let FeelingToday = "Como você está se sentido hoje?"
        static let ChooseMotives = "Escolha um ou mais motivos"
        static let AvailableCharacters = "Disponível 160 caracteres"
        static let popupDescriptionTextMock = "Motivos explicando o porque do seu humor"
        static let TellMore = "Conte mais..."
        static let Available = "Disponível"
        static let Characters = "caracteres"
        static let textConcatenation = "%@ %i %@."
        
        static let Transportation = "Transporte"
        static let Security = "Segurança"
        static let Relationship = "Relacionamento"
        static let Finance = "Finanças"
        static let Studies = "Estudos"
        static let Health = "Saúde"
        static let Physique = "Físico"
        static let Leisure = "Lazer"
        static let Psychological = "Psicológico"
                
        static let Lovesick = "Apaixonado"
        static let Sleepy = "Sono"
        static let Funny = "Engraçado"
        static let Happy = "Feliz"
        static let Amazed = "Espantado"
        static let Tired = "Cansado"
        static let Sad = "Triste"
        static let Angry = "Raiva"
        static let Frustrated = "Frustrado"
        static let Hungry = "Com fome"
        static let Sick = "Doente"
        static let Worried = "Preocupado"
        
        static let Dawn = "Madrugada"
        static let Morning = "Manhã"
        static let Afternoon = "Tarde"
        static let Night = "Noite"
    }
    
    struct Animations {
        static let TransportationAnimation = "Transport"
        static let SecurityAnimation = "Security"
        static let RelationshipAnimation = "Relationship"
        static let FinanceAnimation = "Finance"
        static let StudiesAnimation = "Studies"
        static let HealthAnimation = "Health"
        static let PhysiqueAnimation = "Physique"
        static let LeisureAnimation = "Leisure"
        static let PsychologicalAnimation = "Psychological"
        static let CongratulationsAnimation = "Congratulations"
    }
    
    struct Images {
        static let LeftButton = "left207"
        static let arrowCircleRight = "arrow_circle_right"
        static let arrowCircleLeft = "arrow_circle_left"
        static let iconCheckGreen = "icon_check_green"
        
        static let LovesickImage = "ic_apaixonado"
        static let SleepyImage = "ic_sono"
        static let FunnyImage = "ic_engracado"
        static let HappyImage = "ic_feliz"
        static let AmazedImage = "ic_espantado"
        static let TiredImage = "ic_entediado"
        static let SadImage = "ic_triste"
        static let AngryImage = "ic_raiva"
        static let FrustratedImage = "ic_frustrado"
        static let HungryImage = "ic_fome"
        static let SickImage = "ic_doente"
        static let WorriedImage = "ic_preocupado"
        
        static let MissionsMoodSummary = "missions_mood_summary"
        static let CertificateMoodSummary = "certificate_mood_summary"
    }
    
    struct Storyboards {
        static let Home = "Home"
        static let HomeView = "HomeView"
        static let MyMood = "MyMood"
        static let MyMoodView = "MyMoodView"
        static let MyMoodGraph = "MyMoodGraph"
        static let MyMoodGraphView = "MyMoodGraphView"
    }
    
    struct NSCoding {
        static let KeyMoodImg = "moodImg"
        static let KeyMoodName = "moodName"
        static let KeyMoodCod = "moodCod"
        static let KeySelected = "selected"
    }
    
    struct Fonts {
        static let RobotoBold = "Roboto-Bold"
    }
    
    struct Cells {
        static let MoodCell = "MoodCell"
        static let MoodGraphCell = "MoodGraphCell"
        static let MoodSummaryCell = "MoodSummaryCell"
    }
}
