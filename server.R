shinyServer(
  function(input,output){
    
    
    
    model<-lm(Deaths~Crude.Death.Rate+Lower.Confidence.Limit.for.Crude.Rate+Upper.Confidence.Limit.for.Crude.Rate,data=mydata)
    
    modelpredicted<-reactive({
      deathInput1<- input$bin1
      deathInput2<-input$bin2
      deathInput3<-input$bin3
      
      predict(model, newdata=data.frame(Crude.Death.Rate=deathInput1,
                                        Lower.Confidence.Limit.for.Crude.Rate=deathInput2,
                                        Upper.Confidence.Limit.for.Crude.Rate=deathInput3))
      
      
    })
    
    deaths<- reactive({
      
      deathInput1<- input$bin1
      deathInput2<-input$bin2
      deathInput3<-input$bin3
    })
    
    output$my_plot<-renderPlot(
      
      ggplot(mydata,aes(x=Crude.Death.Rate+Lower.Confidence.Limit.for.Crude.Rate+ Upper.Confidence.Limit.for.Crude.Rate,y=residualVal2))+
        geom_smooth(method=lm,se=FALSE,color="grey")+
        geom_segment(aes(xend= Crude.Death.Rate+Lower.Confidence.Limit.for.Crude.Rate+Upper.Confidence.Limit.for.Crude.Rate,yend=residualVal2),alpha=0.2)+
        geom_point(aes(color=abs(residualVal2)))+scale_color_continuous(low="orange",high="green")+guides(color=FALSE)+geom_point(aes(y=predictedVal2),shape=1)+
        geom_point(aes(x=deaths(),y=0),color="blue",size=6)
    )
    
    output$Predicted<- renderText(
      
      modelpredicted()
    )
  }
)