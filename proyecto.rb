require 'byebug'
require 'terminal-table'

def limpiar_pantalla
  system('clear')
end
def ver_canti_libros_de_un_autor(nombre,pila)#complemento**************
  libro = pila[:tope]
  conta=1
  unidad=0
  while conta<=pila[:size]
    if libro[:autor]==nombre
      unidad+=1
    end

    if  libro[:siguiente]==nil
      conta=pila[:size]+1

    else
      nuevo_elemento = libro[:siguiente]
      libro = nuevo_elemento
      conta+=1
    end
  end
  return unidad
end

# VER UNIDADES
def ver_unidades(pila,isbn)#cambio#*****complemento
  libro = pila[:tope]
  conta=1
  unidad=0
  while conta<=pila[:size]
    if libro[:ISBN]==isbn
      unidad+=1
    end

    if  libro[:siguiente]==nil
      conta=pila[:size]+1

    else
      nuevo_elemento = libro[:siguiente]
      libro = nuevo_elemento
      conta+=1
    end
  end
  return unidad
end


#BUSCAR AUTOR
def buscar_autor(cola,nombre)
  elemento = cola[:tope]
  conta=1
  while conta<=cola[:size]
    if elemento[:nombre]==nombre
      conta=6
      return elemento
      break
    elsif   elemento[:siguiente]==nil && elemento[:valor]!=nombre
      return '***El autor no existe en el sistema***'
      break
    else
      nuevo_elemento = elemento[:siguiente]
      elemento = nuevo_elemento
      conta+=1
    end
  end
end
#1.f MOSTRAR autor
def mostrar_autor(cola,pila)
  if cola[:max]==5
    puts 'no hay autores para mostrar'
  else
    print 'Ingrese el nombre del autor: '
    nombre = gets.chomp
    elemento = buscar_autor(cola,nombre)
    if elemento=='***El autor no existe en el sistema***'
      puts elemento
    else
      if elemento[:libros]==0#cambio
        tabla = Terminal::Table.new do |t|
        t.title = "Nombre Autor: #{elemento[:nombre]}"
        t.add_row(['El autor no tiene ningun libro'])
      end
        puts tabla
      else
        tope = pila[:tope]
        tabla = Terminal::Table.new do |t|
        t.title = " Autor -#{elemento[:nombre]}-"
        t.headings=(['ISBN','NOMBRE','PRECIO','Unidades'])
    loop do
      if tope[:autor] == elemento[:nombre] && tope[:se_imprime] != 'no'
      t.add_row([
        tope[:ISBN],
        tope[:nombre],
        tope[:precio],
        ver_unidades(pila,tope[:ISBN])

      ])
      if tope[:siguiente] == nil
        break
      end
      tope = tope[:siguiente]
    else
    if tope[:siguiente] == nil
      break
    end
    tope = tope[:siguiente]
  end
      end

        end
        puts tabla
      end

    end
  end
    gets
end



#1.b Registro de autor
def nuevo_autor(cola)
  if cola[:max]>0
    if cola[:esta_vacio]                   #SI NO HAY NINGUN AOUTOR EN LA PILA
      print 'Ingrese el nombre del autor: '
      nombre_autor = gets.chomp
      autor = {
        nombre:nombre_autor,
        libros: 0,
        siguiente:nil,#cambio
      }
      cola[:tope] = autor
      cola[:final] = autor
      cola[:esta_vacio] = false
      cola[:max]-=1
      cola[:size]+=1
    else                                      #SI YA HAY MAS DE UN AUTOR EN LA PILA
      print 'Ingrese el nombre del autor: '
      nombre_autor = gets.chomp
      elemento = cola[:tope]
      conta=1
      b=0
      while conta<=cola[:size]                #VERIFICANDO QUE NO EXISTA UN AUTOR CON EL MISMO NOMBRE EN LA PILA
        if elemento[:nombre]==nombre_autor
          b+=1
        end
        if conta!=cola[:size]
        nuevo_elemento = elemento[:siguiente]
        elemento = nuevo_elemento
        end
      conta+=1

    end
    if b>0                                 #CONDICION CUANDO HAY UN AUTOR CON EL MISMO NOMBRE
      puts '***ya existe un autor con este nombre***'
    else                                      #SI NO HAY UN AUTOR CON EL MISMO NOMBRE
      autor = {
        nombre:nombre_autor,
        libros: 0,
        libros1: nil,
        esta_vacio: true,
        siguiente:nil,
      }
      a = cola[:final]
      a[:siguiente] = autor
      cola[:final] = autor
      cola[:max]-=1
      cola[:size]+=1
    end
    end
  else
    puts "\n***Ya no tiene espacio para mas autores***"

  end
gets
end
#1.d Lista de autores
def lista_de_autores(cola,pila)
  if cola[:max]==5
    puts "***No hay autores en el sistema***"
  else
    tabla = Terminal::Table.new do |t|
    t.title = 'Lista De Autores'
    t.headings = ['Nombre', 'Libros']

    aux = cola[:tope]
    loop do
      siguiente = aux[:siguiente]
      t.add_row([
        aux[:nombre],
        ver_canti_libros_de_un_autor(aux[:nombre],pila)
      ])
      if aux[:siguiente] == nil
        break
      end
      aux = aux[:siguiente]
    end
  end

  puts tabla
  end
  gets
end#fin lista de autores
#B. Libro
def buscar_libro(pila,isbn)#cambio
  libro = pila[:tope]
  conta=1
  while conta<=pila[:size]
    if libro[:ISBN]==isbn
      conta=pila[:size]+1
      return libro
    elsif   libro[:siguiente]==nil && libro[:ISBN]!=isbn
      return 'no existe el libro'
      break
    else
      nuevo_elemento = libro[:siguiente]
      libro = nuevo_elemento
      conta+=1
    end
  end
end
#1.a Nuevo libro
def registro_nuevo_libro(pila,cola)
  if cola[:esta_vacio]
    puts 'No existen autores en el sistema. '
  else
    print 'Ingrese el nombre del autor:'
    nombre_autor = gets.chomp
    nodo_autor = buscar_autor(cola,nombre_autor)
    if nodo_autor == '***El autor no existe en el sistema***'
      puts nodo_autor
    else
        if pila[:esta_vacio]#cambio
          print 'Ingrese el ISBN: '
          isbn = gets.chomp
          print 'Ingrese el nombre del libro: '
          nombre_libro = gets.chomp
          print 'Ingrese el precio: '
          precio_libro = gets.to_i
          libro = {
            nombre:nombre_libro,
            ISBN:isbn,
            autor: nombre_autor,
            precio: precio_libro,
            se_imprime: 'si',
            siguiente: nil
          }
          pila[:tope]=libro
          pila[:esta_vacio]=false#cambio
          pila[:size]+=1#suma de libros
          nodo_autor[:libros]+=1
        else
          print 'Ingrese el ISBN: '
          isbn = gets.chomp
          nodo_libro = buscar_libro(pila,isbn)#cambio pila
          if nodo_libro == 'no existe el libro'
          print 'Ingrese el nombre del libro: '
          nombre_libro = gets.chomp
          print 'Ingrese el precio: '
          precio_libro = gets.to_i
          libro = {
            nombre:nombre_libro,
            ISBN:isbn,
            autor: nombre_autor,
            precio: precio_libro,
            se_imprime:'si',
            siguiente: nil
          }
          tope = pila[:tope]#cambio
          libro[:siguiente] = tope
          pila[:tope] = libro
          pila[:size]+=1 #suma de libros
          nodo_autor[:libros]+=1
          else
            if nombre_autor == nodo_libro[:autor]
            puts "El ISBN ingresado pertenece al libro -#{nodo_libro[:nombre]}-"
            puts "Perteneciente al autor -#{nodo_libro[:autor]}-"
            puts "Usted tendra una unidad mas de este libro"
            libro = {
            nombre:nodo_libro[:nombre],
            ISBN:nodo_libro[:ISBN],
            autor: nodo_libro[:autor],
            precio: nodo_libro[:precio],
            se_imprime: 'no',
            siguiente: nil
            }
            tope = pila[:tope]#cambio
            libro[:siguiente] = tope
            pila[:tope] = libro
            pila[:size]+=1 #suma de libros
            nodo_autor[:libros]+=1
            else
              puts "El ISBN #{isbn} le pertene al  libro -#{nodo_libro[:nombre]}-"
              puts "Perteneciente al autor -#{nodo_libro[:autor]}-"
              puts "Ingrese un ISBN DIFERENTE!!!"
            end

          end#fin del if si se encuntra un isbn igual al ingresado. se busca en el nodo autor

        end#fin de ingresar un libro en un autor sin libro
    end#fin condicion busqueda del autor
  end#fin primer if----------
  gets
end#fin de la funcion------------


#1.c lista de libros
def lista_libros(pila)
  if pila[:tope] == nil
    puts 'No hay libros en el sistema'
  else
  tabla = Terminal::Table.new do |t|
    t.title = 'LISTA DE LIBROS'
    t.headings = ['ISBN', 'Nombre', 'Precio','Autor','Unidades']

    aux = pila[:tope]

    loop do
      if aux[:se_imprime]!='no'
      t.add_row([
        aux[:ISBN],
        aux[:nombre],
        aux[:precio],
        aux[:autor],
        ver_unidades(pila,aux[:ISBN])
      ])
    end
      if aux[:siguiente] == nil
        break
      end
      aux = aux[:siguiente]
    end
  end

  puts tabla
end
  gets
end
#1.eBUSCAR UN LIBRO
def buscar_libro1(pila)
  libro = pila[:tope]
  print 'Ingrese el ISBN: '
  isbn = gets.chomp
  conta=1
  b=0
  while conta<=pila[:size]
    if isbn == libro[:ISBN]
      conta=pila[:size]+1
      b=1
    elsif libro[:siguiente]==nil&&libro[:ISBN]!=isbn
      b=0
    else
      libro = libro[:siguiente]
    end
    conta+=1
  end
  if b==1
    limpiar_pantalla
    tabla = Terminal::Table.new do |t|
      t.headings = ['Nombre','unidades','ISBN','Precio','Unidades']
      t.add_row([
        libro[:nombre],
        libro[:autor],
        libro[:ISBN],
        libro[:precio],
        ver_unidades(pila,libro[:ISBN])
      ])
    end
    puts tabla
  else
    limpiar_pantalla
    puts 'El libro que busca no existe en el sistema'
  end
  gets
end
#..............................................................................................................
#2. control de ventas

def eliminar_un_libro(pila,nodo_libro)
  if   pila[:tope][:siguiente] == nil
    pila[:size]-=1
    pila[:tope] = nil
    pila[:esta_vacio] = true
  elsif pila[:tope][:ISBN] == nodo_libro[:ISBN]
    if pila[:tope]==nil
        pila[:esta_vacio]=true
    else
        pila[:size]-=1
        nodo = pila[:tope]
        pila[:tope] = nodo[:siguiente]
        nodo = nil
    end
  elsif nodo_libro[:siguiente] == nil
    libro=pila[:tope]
    conta = 0
    loop do
      conta+=1
      if conta == pila[:size]-1
        pila[:size]-=1
        libro[:siguiente] = nil
        break
      end
      if libro[:siguiente] == nil
        break
      end
      libro = libro[:siguiente]
  end
  else
    libro=pila[:tope]
    isbn = nodo_libro[:ISBN]
    aux = nodo_libro[:siguiente]
    loop do
      if libro[:siguiente][:ISBN] == isbn
        pila[:size]-=1
        libro[:siguiente]=aux
        break
      end
      if libro[:siguiente] == nil
        break
      end
      libro = libro[:siguiente]
    end
  end

end

def si_desea_ingresar_otro_libro(conta)#************complemento
  limpiar_pantalla
  puts 'Desea ingresar otro libro: 1) si . 2) no'
  print 'ingrese un opcion: '
  opcion = gets.to_i
      case opcion
      when 1
          return 0
      when 2
          return 1
      end
gets
end
#Ingresar el nodo venta  a la cola venta
def ingresar_detalle_en_venta(detalle_venta,venta)#****************complemento
  if venta[:esta_vacio]
    venta[:tope] = detalle_venta
    venta[:final] = detalle_venta
    venta[:esta_vacio] = false
    venta[:size] +=1
    venta[:max]-=1
  else
    final = venta[:final]
    final[:siguiente] = detalle_venta
    venta[:final] = detalle_venta
    venta[:size]+=1
    venta[:max]-=1
  end
end
#buscar una venta
def buscar_venta(venta,codigo)#*************complemento
  elemento = venta[:tope]
      conta=1
      b=0
      while conta<=venta[:size]                #VERIFICANDO QUE NO EXISTA UN AUTOR CON EL MISMO NOMBRE EN LA PILA
        if elemento[:codigo]==codigo
          b+=1
        end
        if conta!=venta[:size]
        nuevo_elemento = elemento[:siguiente]
        elemento = nuevo_elemento
        end
      conta+=1
    end
    return b
end
#Nueva venta
def nuevo_venta(venta,pila,codigo_venta)
      conta = 0
      detalle_venta = {
        size: 0,
        codigo: codigo_venta,
        tope: nil,
        subtotal: 0,
        descuento: nil,
        total_venta: nil,
        esta_vacio: true,
        final: nil,
        siguiente: nil
      }
      begin
        limpiar_pantalla
          #puts detalle_venta
        print 'Ingrese el ISBN del libro a vender: '
        isbn = gets.chomp
        nodo_libro = buscar_libro(pila,isbn) #nodo libro
        if nodo_libro == 'no existe el libro'
          limpiar_pantalla
          puts nodo_libro
          gets
          conta=si_desea_ingresar_otro_libro(conta)
        else #else de if nodo_libro == 'no existe el libro'
          if ver_unidades(pila,nodo_libro[:ISBN])==0
            limpiar_pantalla
            puts 'Ya no quedan ejemplares de este libro'
            gets
            conta=si_desea_ingresar_otro_libro(conta)
          else #else nodo_libro[:existencias] == 0
            libro_venta = {
              autor: nodo_libro[:autor],
              nombre: nodo_libro[:nombre],
              precio: nodo_libro[:precio],
              ISBN: nodo_libro[:ISBN],
              siguiente: nil
            }
            if detalle_venta[:esta_vacio]
              detalle_venta[:tope] = libro_venta
              detalle_venta[:final] = libro_venta
              detalle_venta[:esta_vacio] = false
              detalle_venta[:subtotal]+=nodo_libro[:precio]
              #cambio
              detalle_venta[:size]+=1
              eliminar_un_libro(pila,nodo_libro)#eliminar-----------------
              conta=si_desea_ingresar_otro_libro(conta)
            else#else del if detalle_venta[:esta_vacio]
                final = detalle_venta[:final]
                final[:siguiente] = libro_venta
                detalle_venta[:final] = libro_venta
                detalle_venta[:size]+=1
                detalle_venta[:subtotal]+=nodo_libro[:precio]
                #cambio
                eliminar_un_libro(pila,nodo_libro)#eliminar---------------
                conta=si_desea_ingresar_otro_libro(conta)
            end#fin de la condicion si el nodo de detalle_venta esta vacia o no
          end#fin de si existen existencias del libro.
        end#fin si existe o no el libro.
      end while  conta!=1
      return detalle_venta
end
#hacer descuento
def descuento(detalle_venta)
  libro_nodo = detalle_venta[:tope]
  b=0
  a=0
  if   detalle_venta[:size]<=1
    detalle_venta[:descuento]=0
    detalle_venta[:total_venta]=detalle_venta[:subtotal]
    return detalle_venta
else
  begin
    if libro_nodo[:ISBN] !=libro_nodo[:siguiente][:ISBN]
      b+=1
    end
    if libro_nodo[:autor] != libro_nodo[:siguiente][:autor]
      a+=1
    end
      libro_nodo = libro_nodo[:siguiente]
  end while libro_nodo[:siguiente]!=nil
    descuento1 = 0
    descuento2 = 0
  if  b==2
    descuento1 += (detalle_venta[:subtotal]*0.1)
  end
  if b>=3
    descuento1 += (detalle_venta[:subtotal]*0.2)
  end
  if a>=2
    descuento2 += (detalle_venta[:subtotal]*0.05)
  end
  descuento_total = descuento1+descuento2
  detalle_venta[:descuento] = descuento_total
  detalle_venta[:total_venta] = detalle_venta[:subtotal]-detalle_venta[:descuento]

  return detalle_venta
end

end
#eliminar_una venta
def eliminar_una_venta(venta)
        venta[:size]-=1
        nodo = venta[:tope]
        venta[:tope] = venta[:siguiente]
        nodo = nil
end
#2.a registro venta
def registro_de_ventas(venta,pila)
  if pila[:tope]==nil
    puts 'No hay libros en el sistemas'
  else #else de pila[:tope]==nil
    if venta[:esta_vacio]
      codigo_venta="" #asignar una venta
      for i in 1..3   #asignar una venta
      num=rand(0...3)    #...
      codigo_venta+="#{num}"#...
    end
      detalle_venta=nuevo_venta(venta,pila,codigo_venta)
      if detalle_venta[:tope] == nil
          puts 'no se produjo una venta'
        else
          ingresar_detalle_en_venta(descuento(detalle_venta),venta)
        end

    else
      if venta[:max]>0
      codigo_venta="" #asignar una venta
      for i in 1..3   #asignar una venta
      num=rand(0...3)    #...
      codigo_venta+="#{num}"#...
      end
      if buscar_venta(venta,codigo_venta)>0
        puts 'El codigo que ingreso ya le pertenece a una venta en el sistema'
      else
        detalle_venta= nuevo_venta(venta,pila,codigo_venta)
        if detalle_venta[:tope] == nil
          puts 'no se produjo una venta'
        else

          ingresar_detalle_en_venta(descuento(detalle_venta),venta)
        end
      end
    else
      eliminar_una_venta(venta)
      codigo_venta="" #asignar una venta
      for i in 1..3   #asignar una venta
      num=rand(0...3)    #...
      codigo_venta+="#{num}"#...
      end
      if buscar_venta(venta,codigo_venta)>0
        puts 'El codigo que se ingreso ya existe en una venta. Vuelva a intentar'
      else
        detalle_venta= nuevo_venta(venta,pila,codigo_venta)
        if detalle_venta[:tope] == nil
          puts 'no se produjo una venta'
        else

          ingresar_detalle_en_venta(descuento(detalle_venta),venta)#pendiente agregar descuento
        end
      end
    end#..................................
    end#if esta vacio
  end#if pila tope
      gets
end#fin de registro de ventas

# Buscar una venta por nodo
def buscar_una_venta_en_cola(venta,codigo)
  elemento = venta[:tope]
  conta=1
  while conta<=venta[:size]
    if elemento[:codigo]==codigo
      conta=venta[:size]+1
      return elemento
      break
    elsif   elemento[:siguiente]==nil && elemento[:codigo]!=codigo
      return 'La venta no existe en el sistema'
      break
    else
      nuevo_elemento = elemento[:siguiente]
      elemento = nuevo_elemento
      conta+=1
    end
  end
end
#2.b buscar una venta
def mostrar_una_venta(venta)
  if venta[:tope] == nil
    puts 'No hay ventas en el sistemas'
  else
  print 'Ingrese el cogido de la venta: '
  codigo = gets.chomp
  nodo_venta = buscar_una_venta_en_cola(venta,codigo)
  if nodo_venta == 'La venta no existe en el sistema'
    puts nodo_venta
  else
    tabla = Terminal::Table.new do |t|
  t.title = 'BUSCAR UNA VENTA'
  t.headings=['codigo','subtotal','descuento','total de venta','libros vendidos']
  t.add_row([
    nodo_venta[:codigo],
    nodo_venta[:subtotal],
    nodo_venta[:descuento],
    nodo_venta[:total_venta],
    nodo_venta[:size]
  ])
end
  tabla2 = Terminal::Table.new do |a|
    a.title = 'Lista de libros vendidos'
    a.headings = ['Autor', 'Nombre', 'Precio','ISBN']

    aux = nodo_venta[:tope]
    loop do
      a.add_row([
        aux[:autor],
        aux[:nombre],
        aux[:precio],
        aux[:ISBN]
      ])
      if aux[:siguiente] == nil
        break
      end
      aux = aux[:siguiente]
    end
  end
  puts tabla
  puts tabla2
  end
end#fin primer if
gets
end
#lista de ventas**
def lista_ventas(venta)
  if venta[:tope] == nil
    puts 'No hay ventas en el sistema'
  else
    tabla2 = Terminal::Table.new do |a|
    a.title = 'Lista de libros vendidos'
    a.headings = ['Codigo', 'Subtotal', 'Descuento','Total venta','Libros vendidos']

    aux = venta[:tope]
    loop do
      a.add_row([
        aux[:codigo],
        aux[:subtotal],
        aux[:descuento],
        aux[:total_venta],
        aux[:size]
      ])
      if aux[:siguiente] == nil
        break
      end
      aux = aux[:siguiente]
    end
  end
  puts tabla2
  end
  gets
end
venta = {
  tope: nil,
  max: 20,
  size: 0,
  esta_vacio: true,
  final: nil


}


#colas,pilas............**......
  cola = {
      tope: nil,
      esta_vacio: true,
      final: nil,
      max: 5,
      size: 0
  }
  pila = {
    tope: nil,
    esta_vacio: true,
    size: 0
  }
  begin


#MENU PRINCIPAL
tabla = Terminal::Table.new do |t|
  t.title = 'SEGUNDO PROYECTO-INVENTARIO LIBRERIA-MENU PRINCIPAL'
  t.headings=["No.","Opcion"]
  t.add_row(['1','registro de nuevos libros'])
  t.add_row(['2','Control de ventas'])
  t.add_row(['3','salir'])
end
tabla2 = Terminal::Table.new do |a|
  a.title = 'ANDMINISTRACION DE LIBROS'
  a.headings=['No.','Opciones']
  a.add_row(['1','registro de nuevo libro'])
  a.add_row(['2','registro de nuevo autor'])
  a.add_row(['3','buscar libro'])
  a.add_row(['4','buscar autor'])
  a.add_row(['5','lista de autores'])
  a.add_row(['6','lista de libros'])
  a.add_row(['7','salir'])
end

tabla3 = Terminal::Table.new do |n|
  n.title = 'CONTROL DE VENTAS'
  n.headings = ['No.','Opciones']
  n.add_row(['1','registro de una venta'])
  n.add_row(['2','buscar una venta'])
  n.add_row(['3','listado de ventas'])
  n.add_row(['4','salir'])
end


begin
  limpiar_pantalla
puts tabla
print 'Ingrese una opcion: '
opc = gets.chomp
limpiar_pantalla()
case opc
when '1'
    begin
      limpiar_pantalla
      puts tabla2
      print 'Ingrese una opcion: '
      opc2 = gets.chomp
      limpiar_pantalla()
      case opc2
      when '1'
        registro_nuevo_libro(pila,cola)
      when '2'
        nuevo_autor(cola)
      when '3'
        buscar_libro1(pila)
      when '4'
        mostrar_autor(cola,pila)
      when '5'
        lista_de_autores(cola,pila)
      when '6'
        lista_libros(pila)
      end
    end while opc2!='7'
when '2'
  begin
    limpiar_pantalla
    puts tabla3
    print 'Ingrese una opcion: '
    opc3 = gets.chomp
    limpiar_pantalla()
    case opc3
    when '1'
      registro_de_ventas(venta,pila)
    when '2'
      mostrar_una_venta(venta)
    when '3'
      lista_ventas(venta)
    end
  end while opc3!='4'
end
end while opc!='3'
end


