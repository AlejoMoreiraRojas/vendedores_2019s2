import ciudades.*

class Vendedor {
	const property certificaciones = []
	
	method esFisico() = true
	
	method puedeTrabajarEn(unaCiudad)
	method esInfluyente()

	method agregarCertificacion(certificacion){
		self.certificaciones().add(certificacion)
	}
	
	method puntajeTotal(){
		const puntajes = {c => c.puntaje()}
		
		return self.certificaciones().sum(puntajes)
	}
	
	
	method esVersatil(){
		const productos = {c => c.esSobreProducto()}
		const noProductos = {c => not c.esSobreProducto()}
		
		return 	self.certificaciones().size() >= 3
				&&
				self.certificaciones().count(productos) >= 1
				&&
				self.certificaciones().count(noProductos) >= 1
	}
	
	method esFirme(){
		const puntajes = {c => c.puntaje()}
		
		return self.certificaciones().sum(puntajes) >= 30
	}
	
	method esGenerico(){
		const generico = {c => not c.esSobreProducto()}
		
		return self.certificaciones().any(generico)
	}
	
	method tieneAfinidadPor(unCentro){
		return self.puedeTrabajarEn(unCentro.ciudad())
	}
}


class VendedorFijo inherits Vendedor {
	var property ciudadDondeVive
	
	override method puedeTrabajarEn(unaCiudad){
		return self.ciudadDondeVive() == unaCiudad
	}
	
	override method esInfluyente(){
		return false
	}
}


class Viajante inherits Vendedor {
	const property provinciasDondeTrabaja = []
	
	override method puedeTrabajarEn(unaCiudad){
		const tieneCiudad = {p => p.contains(unaCiudad)}
		return self.provinciasDondeTrabaja().any(tieneCiudad)
	}
	
	override method esInfluyente(){
		const poblaciones = {p => p.poblacion()}
		
		return self.provinciasDondeTrabaja().sum(poblaciones) >= 10**7
	}
}


class ComercioCorresponsal inherits Vendedor {
	const property sucursalesEn = []
	
	override method esFisico() = false
	
	override method puedeTrabajarEn(unaCiudad){
		return self.sucursalesEn().contains(unaCiudad)
	}
	
	override method esInfluyente(){
		const provincias = {c => c.provincia()}
		
		return 	self.sucursalesEn().size() >= 5
				||
				self.sucursalesEn().map(provincias).asSet().size() >= 3
	}
	
	override method tieneAfinidadPor(unCentro){
		const noPuedeCubrir = {c => not unCentro.puedeCubrir(c)}
		
		return 	super(unCentro)
				&&
				self.sucursalesEn().any(noPuedeCubrir)
	}
}


class Certificacion {
	var property puntaje
	var property esSobreProducto = true
}