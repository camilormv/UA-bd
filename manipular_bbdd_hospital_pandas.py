import psycopg2
from tabulate import tabulate

# Configuración de la conexión a la base de datos
conn = psycopg2.connect(
    dbname="clinica",
    user="postgres",
    password="your_password",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

def mostrar_pacientes():
    cur.execute("""
    SELECT pg.id_paciente, pg.Nombre, pd.Diagnostico, m.Nombre AS medico_tratante, h.nombre_habitacion
    FROM pacientes_general pg
    JOIN pacientes_detalle pd ON pg.id_paciente = pd.id_paciente
    JOIN medicos m ON pd.medico_tratante = m.id_medico
    JOIN camas c ON pd.id_cama = c.id_cama
    JOIN habitaciones h ON c.id_habitacion = h.id_habitacion
    """)
    pacientes = cur.fetchall()
    print(tabulate(pacientes, headers=["RUT", "Nombre", "Diagnóstico", "Médico Tratante", "Habitación"], tablefmt="grid"))

def mostrar_detalle_paciente(rut):
    cur.execute("""
    SELECT pg.id_paciente, pg.Nombre, pd.Diagnostico, m.Nombre AS medico_tratante, 
           e.tipo_examen, e.resultado, h.nombre_habitacion, c.id_cama
    FROM pacientes_general pg
    JOIN pacientes_detalle pd ON pg.id_paciente = pd.id_paciente
    JOIN medicos m ON pd.medico_tratante = m.id_medico
    JOIN camas c ON pd.id_cama = c.id_cama
    JOIN habitaciones h ON c.id_habitacion = h.id_habitacion
    LEFT JOIN examenes e ON pd.id_examen = e.id_examen
    WHERE pg.id_paciente = %s
    ORDER BY e.fecha DESC
    LIMIT 1
    """, (rut,))
    detalle = cur.fetchone()
    if detalle:
        print(tabulate([detalle], headers=["RUT", "Nombre", "Diagnóstico", "Médico Tratante", 
                                             "Último Examen", "Resultado", "Habitación", "Cama"], tablefmt="grid"))
    else:
        print("Paciente no encontrado.")

def cambiar_cama(rut, nueva_cama):
    cur.execute("UPDATE pacientes_detalle SET id_cama = %s WHERE id_paciente = %s", (nueva_cama, rut))
    conn.commit()
    print("Cama del paciente actualizada.")

def cambiar_medico(rut, nuevo_medico):
    cur.execute("UPDATE pacientes_detalle SET medico_tratante = %s WHERE id_paciente = %s", (nuevo_medico, rut))
    conn.commit()
    print("Médico del paciente actualizado.")

def crear_cama_y_habitacion(id_habitacion, nombre_habitacion, piso, id_cama, estado):
    cur.execute("INSERT INTO habitaciones (id_habitacion, nombre_habitacion, piso) VALUES (%s, %s, %s)", 
                (id_habitacion, nombre_habitacion, piso))
    cur.execute("INSERT INTO camas (id_cama, id_habitacion, estado) VALUES (%s, %s, %s)", 
                (id_cama, id_habitacion, estado))
    conn.commit()
    print("Cama y habitación creadas.")

def mostrar_todas_tablas():
    # Mostrar todas las filas de cada tabla
    tablas = ["habitaciones", "camas", "pacientes_general", "medicos", "examenes", "pacientes_detalle"]
    for tabla in tablas:
        print("\n--- Datos de la tabla:", tabla, "---")
        cur.execute("SELECT * FROM " + tabla + ";")
        datos = cur.fetchall()
        if datos:
            for fila in datos:
                print(fila)
        else:
            print("No hay datos en la tabla", tabla)
        print("-" * 40)

def menu():
    while True:
        print("\n--- Menú de Gestión de Clínica ---")
        print("1. Mostrar pacientes")
        print("2. Mostrar detalle de un paciente")
        print("3. Cambiar paciente de cama")
        print("4. Cambiar paciente de médico")
        print("5. Crear camas y habitaciones")
        print("6. Desplegar todas las tablas")
        print("0. Salir")
        
        opcion = input("Seleccione una opción: ")
        
        if opcion == '1':
            mostrar_pacientes()
        elif opcion == '2':
            rut = input("Ingrese el RUT del paciente: ")
            mostrar_detalle_paciente(rut)
        elif opcion == '3':
            rut = input("Ingrese el RUT del paciente: ")
            nueva_cama = input("Ingrese el ID de la nueva cama: ")
            cambiar_cama(rut, nueva_cama)
        elif opcion == '4':
            rut = input("Ingrese el RUT del paciente: ")
            nuevo_medico = input("Ingrese el ID del nuevo médico: ")
            cambiar_medico(rut, nuevo_medico)
        elif opcion == '5':
            id_habitacion = input("Ingrese el ID de la habitación: ")
            nombre_habitacion = input("Ingrese el nombre de la habitación: ")
            piso = input("Ingrese el piso: ")
            id_cama = input("Ingrese el ID de la cama: ")
            estado = input("Ingrese el estado de la cama: ")
            crear_cama_y_habitacion(id_habitacion, nombre_habitacion, piso, id_cama, estado)
        elif opcion == '6':
            mostrar_todas_tablas()
        elif opcion == '0':
            break
        else:
            print("Opción no válida. Intente de nuevo.")

if __name__ == "__main__":
    menu()
    cur.close()
    conn.close()