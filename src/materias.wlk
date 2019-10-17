class Estudiante{
	var aprobacion = []
	var carreras = []
	




	method estaCursando(){
		return carreras.asSet()
	}

	method registrarAprobacion(laMateria,laNota){
		var apr = new Aprobacion()
		apr.nota(laNota)
		apr.materia(laMateria)
		
		aprobacion.add(apr)
	}
	method registrarAprobacion2(materia,nota){
		if(not aprobacion.any({aprob => aprob.materia() == materia}) ){
			aprobacion.add(new Aprobacion(nota= nota,materia = materia))
		}
		else {self.error("ya esta aprobada")}
	}
	method materiaDeCarrerasInscripto(){

		return carreras.map({carr => carr.materias()}).flatten()
	
	}
	method estaAprobado(materia){
		return aprobacion.any({aprob => aprob.materia() == materia})
	}
	
	
	method cantidadDeMateriaAprobadas(){
		return aprobacion.size()
	}
	method promedio(){
		return aprobacion.sum({aprob => aprob.nota()/self.cantidadDeMateriaAprobadas()})
	}
	
	
	method puedeInscribirseMateria(materia){
		return self.aprobadoLaMateria(materia) 
		and self.estaEnMateria(materia)
		and self.alumnoEstaInscripto(materia)
		and self.materiaRequisitos(materia)
			
		
	}

	method inscribirseMateria(materia){
	 	carreras.add(materia)
	}
	
	method aprobadoLaMateria(materia){
		return not self.estaAprobado(materia)
	}
	method alumnoEstaInscripto(materia){
		return not carreras.any(materia)
	}
	method materiaRequisitos(materia){
		return carreras.all({aprob => aprob.estaAprobado(materia)})
	}
	method estaEnMateria(materia){
		return carreras.contains(materia)
	}
	
	
	
	
}

class Materia{
	var property requisitos = []
	var property estudiantesInscriptos = []
	var property listaDeEspera = []
	var property cantidadMaximaDeEstudiantes
	
	method correlativa(materia){
		requisitos.add(materia)
	}
	
	method inscribirEstudiante(estudiante){
		if(estudiantesInscriptos.size()<=cantidadMaximaDeEstudiantes){
			estudiantesInscriptos.add(estudiante)
		}
		else{
			listaDeEspera.add(estudiante)
		}
	}
	method darDeBaja(estudiante){
		estudiantesInscriptos.remove(estudiante)
		if (not listaDeEspera.isEmpty()){
			estudiantesInscriptos.add(listaDeEspera.head())
			listaDeEspera.remove(listaDeEspera.head())			
			}
	}
	
	
	
}



class Aprobacion{

	var property nota
	var property materia
	
	
}
class Materias{
	var property nombre
	var property materiaRequisitos
	
	
}

object programacion{}
object medicina{}
object derecho{}