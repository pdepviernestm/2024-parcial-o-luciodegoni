class Persona {
    const edad
    const emociones = []

    method esAdolescente() = edad.between(12, 19)
    method agregarEmocion(emocion) = emociones.add(emocion)
    method vaAExplotar() = emociones.all({e=> e.puedeLiberarse()})
    method vivirUnEvento(evento) {emociones.forEach{emocion => emocion.vivirEvento(evento)} }
} 

class Evento {
    var property impacto
    const property descripcion 

}

class Emocion {
    var property intensidadElevada = 50
    var property intensidad
    var property volverALiberarse = true
    var property eventosVividos = 0
    
    method modificarIntensidadElevada(valor) {
        intensidadElevada = valor
    }
    method puedeLiberarse() = self.esIntensa()
    method liberar(evento){
        if(self.puedeLiberarse()){
            intensidad -= evento.impacto()
        }
    }
    method esIntensa() = intensidad > intensidadElevada

    method vivirEvento(evento) {
        self.liberar(evento)
        eventosVividos += 1
  }
}

  const furia = new Furia(palabrotas=["HD!#!!P#", "Horrendo"])
class Furia inherits Emocion(intensidad = 100) {
    const palabrotas = []
    
    method sabePalabrotaLarga(n) = palabrotas.any({p => p.size() > n}) 
    method eliminarPrimeraPalabrota() = palabrotas.remove(palabrotas.first())
    override method puedeLiberarse()= super() && self.sabePalabrotaLarga(7)  
    override method liberar(evento){
        if(self.puedeLiberarse()){
            super(evento)
            self.eliminarPrimeraPalabrota()
        }
    }

}

class Alegria inherits Emocion {
    override method intensidad(nuevaIntensidad) {
    if (nuevaIntensidad < 0) 
      intensidad = -nuevaIntensidad
    else 
      intensidad = nuevaIntensidad
  }
    override method puedeLiberarse() = super() && self.eventosVividos().even() 
    override method liberar(evento) {
        if(self.puedeLiberarse()){
            super(evento)
            
        }
    }
}

class Tristeza inherits Emocion{
    var property causa = "melancolia"
    override method puedeLiberarse() =  super() && (self.causa() != "melancolia")
    override method liberar(evento){
        if(self.puedeLiberarse()){
            causa = evento.descripcion() 
        }
        
    }
}

class Desagrado inherits Emocion{

    override method puedeLiberarse() = super() && self.eventosVividos() > intensidad
    override method liberar(evento) {
        if(self.puedeLiberarse()){
            intensidad -= evento.impacto() 
        } 
}
}

class Temor inherits Desagrado {

}


// La ansiedad puede ser liberada cuando tiene
// una intensidad elevada y un nivel de ansiedad mayor a 100. Liberarse consiste en disminuir
// la intensidad tantas unidades como el impacto del evento y agregar a los eventos vividos el 
//evento trauma
class Ansiedad inherits Emocion {
    var property nivelAnsiedad
    override method puedeLiberarse() = super() && self.nivelAnsiedad() > 100
    override method liberar(evento){
        if(self.puedeLiberarse()){
            super(evento) && self.eventosVividos().add("trauma") 
        }
    }
}

// Para crear una nueva emocion, nos es muy util el concepto de herencia ya que todas las
// emociones comparten varios de sus comportamientos y manejan los mismos metodos.
// El polimorfismo lo que nos va a permitir es tratar a todas las emociones de igual manera
// aunque sus metodos en parte hagan cosas distintas o tengan distintas condiciones