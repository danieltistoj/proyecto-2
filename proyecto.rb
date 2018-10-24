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
      if tope[:autor] == elemento[:nombre] && tope[:se_imprime] !=nil
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


