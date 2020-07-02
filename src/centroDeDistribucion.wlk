import ciudades.*
import vendedores.*

class CentroDeDistribucion {
	const property ciudad
	const property vendedores = []
	
	method agregarVendedor(unVendedor){
		if( self.vendedores().contains(unVendedor) ){
			throw new Exception(message = ("Ya trabajamos con este vendedor."))
		}
		else{
			self.vendedores().add(unVendedor)
		}
	}
	
	method vendedorEstrella(){
		const mayorPuntaje = {v => v.puntajeTotal()}
		
		return self.vendedores().max(mayorPuntaje)
	}
	
	method puedeCubrir(unaCiudad){
		const laCubre = {v => v.puedeTrabajarEn(unaCiudad)}
		
		return self.vendedores().any(laCubre)
	}
	
	method vendedoresGenericos(){
		const losGenericos = {v => v.esGenerico()}
		
		return self.vendedores().filter(losGenericos)
	}
	
	method esRobusto(){
		const losFirmes = {v => v.esFirme()}
		
		return self.vendedores().count(losFirmes) >= 3
	}
	
	method repartirCertificacion(unaCertificacion){
		const entregarCertificacion = {v => v.agregarCertificacion(unaCertificacion)}
		self.vendedores().forEach(entregarCertificacion)
	}
	
	method esCandidato(unVendedor){
		return 	unVendedor.esVersatil()
				&&
				unVendedor.tieneAfinidadPor(self)
	}
}
