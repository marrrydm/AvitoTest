//
//  ViewController.swift
//  AvitoTest
//
//  Created by Мария Ганеева on 19.10.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Private Properties
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: Internal vars
    var presenter: MainViewPresenterProtocol?

    // MARK: - Inheritance
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableConfig()
        navControllerConfig()
        activityIndicatorConfig()
    }

    // MARK: - UI
    private func tableConfig() {
        setupHeader()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ViewCell.self, forCellReuseIdentifier: ViewCell.Constants.id)
    }

    private func activityIndicatorConfig() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupHeader() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        constraintsTableView()
    }

    private func constraintsTableView() {
        let topConstraints = tableView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 0
        )
        let trailingConstraints = tableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        )
        let leadingConstraints = tableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        )
        let heightConstraints = tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        let widthConstraints = tableView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        NSLayoutConstraint.activate([
            topConstraints,
            trailingConstraints,
            leadingConstraints,
            heightConstraints,
            widthConstraints
        ])
    }

    private func navControllerConfig() {
        navigationItem.title = "Список сотрудников"
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.personData?.company.employees.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ViewCell.Constants.id
        ) as? ViewCell else {
            fatalError("failed to get value cell")
        }
        cell.nameLabel.text = "Имя: " + (presenter?.personData?.company.employees[indexPath.row].name ?? "")
        cell.skillsLabel.text = "Навыки: " + (presenter?.personData?.company.employees[indexPath.row].skills.joined(separator: ", ") ?? "")
        cell.phoneLabel.text = "Номер телефона: " + (presenter?.personData?.company.employees[indexPath.row].phoneNumber ?? "")
        cell.contentLabel.text = "Компания: " + (presenter?.personData?.company.name ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        let verticalPadding: CGFloat = 5
        let maskLayer = CALayer()

        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(
            x: cell.bounds.origin.x,
            y: cell.bounds.origin.y,
            width: cell.bounds.width,
            height: cell.bounds.height
        ).insetBy(dx: 0, dy: verticalPadding / 2)
        cell.layer.mask = maskLayer
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MainViewProtocol

extension ViewController: MainViewProtocol {
    func success() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }

    func failure(error: Error) {
        print(error)
    }
}
