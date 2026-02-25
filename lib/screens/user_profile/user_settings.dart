import 'package:flutter/material.dart';
import 'package:mentis_ai/services/database_service.dart';
import 'package:mentis_ai/utils/app-colors.dart';
import 'package:mentis_ai/models/user_data.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _watchController = TextEditingController();

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedEducationLevel;
  String? _selectedProfession;
  String? _selectedIncome;
  String? _selectedFamilyArrangement;
  String? _selectedChildren;
  String? _selectedResidence;

  Future<void> _saveProfile() async {
    if (_selectedGender == null || _selectedEducationLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, preencha os campos obrigatórios")),
      );
      return;
    }

    final user = UserData(
      id: 1,
      gender: _selectedGender!,
      dateOfBirth: _dateController.text,
      maritalStatus: _selectedMaritalStatus ?? 'Não informado',
      educationLevel: _selectedEducationLevel!,
      profession: _selectedProfession ?? 'Não informado',
      income: _selectedIncome ?? 'Não informado',
      familyArrangement: _selectedFamilyArrangement ?? 'Não informado',
      children: _selectedChildren ?? '0',
      residence: _selectedResidence ?? 'Não informado',
      smartwatch: _watchController.text,
    );

    await DataBaseService().saveUser(user);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dados salvos com sucesso!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _watchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Informações gerais"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dados Gerais',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue700,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Gênero',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Masculino', 'Feminino', 'Outro']
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedGender = val;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Data de Nascimento',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1940),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            _dateController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              //Campo de Status Civil
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Status Civil',
                  border: OutlineInputBorder(),
                ),
                items: ['Solteiro(a)', 'Casado(a)']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedMaritalStatus = val;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              const Divider(
                color: AppColors.gray400,
                thickness: 1,
              ),

              const SizedBox(
                height: 14,
              ),

              // Seção de Educação e Profissão
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Educação e Profissão',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue700,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Nível Educacional',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        'Doutorado',
                        'Mestrado',
                        'Graduação',
                        'Ensino Médio',
                        'Ensino Fundamental'
                      ]
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => {
                        setState(() {
                          _selectedEducationLevel = val;
                        })
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Profissão',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        'Estudante',
                        'Autônomo',
                        'Meio Período',
                        'Período Completo',
                        'Autônomo',
                        'Desempregado',
                        'Aposentado'
                      ]
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedProfession = val;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Campo de renda
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Renda',
                  border: OutlineInputBorder(),
                ),
                items: [
                  '0 a 1 vezes o salário mínimo',
                  '2 a 4 vezes o salário mínimo',
                  '5 a 7 vezes o salário mínimo',
                  '8 a 10 vezes o salário mínimo',
                  'Mais que 10 vezes'
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedIncome = val;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              const Divider(
                color: AppColors.gray400,
                thickness: 1,
              ),

              const SizedBox(
                height: 14,
              ),

              //Seção de Residência e Família
              const Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Residência e Família',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue700,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              //Campo de arranjo familiar
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Família',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Moro sozinho',
                  'Moro com 1 ou 2 pessoas',
                  'Moro com 3 ou 4 pessoas',
                  'Moro com 5 ou mais pessoas',
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedFamilyArrangement = val;
                  });
                },
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Filhos',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        'Nenhum',
                        '1 ou 2',
                        '3 ou 4',
                        'Mais que 4',
                      ]
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedChildren = val;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Residência',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        'Área urbana',
                        'Área rural',
                      ]
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedResidence = val;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              //Seção de Residência e Família
              const Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Dados do Smartwatch',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue700,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _watchController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Marca e Modelo',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 32),

              //Botão de salvar os dados do usuário
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4E6B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Salvar Dados",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
