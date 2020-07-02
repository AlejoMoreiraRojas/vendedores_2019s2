class Cliente {	method puedeSerAtendidoPor(unVendedor) }
//			--------PREGUNTAR SI ES NECESARIO ESTA CLASE ABSTRACTA--------

class ClienteInseguro inherits Cliente {
	
	override method puedeSerAtendidoPor(unVendedor){
		return 	unVendedor.esVersatil()
				&&
				unVendedor.esFirme()
	}
}


class ClienteDetallista inherits Cliente {
	
	override method puedeSerAtendidoPor(unVendedor){
		const productos = {c => c.esSobreProducto()}
		
		return unVendedor.certificaciones().count(productos) >= 3
	}
}


class ClienteHumanista inherits Cliente {
	
	override method puedeSerAtendidoPor(unVendedor){
		
		return unVendedor.esFisico()
	}
}