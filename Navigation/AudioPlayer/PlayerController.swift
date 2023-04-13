//
//  PlayerController.swift
//  Navigation
//
//  Created by Ульви Пашаев on 07.03.2023.
//

import Foundation
import UIKit
import AVFoundation
import TinyConstraints //решил испробовать, очень понравилось, удобно и интуитивно!

final class PlayerController: UIViewController {
    
    // MARK: - Properties
    
    public var player = AVAudioPlayer()
    public var trackPosition: Int = 0
    private var timer: Timer?
    public var tracklist = TrackModel.tracks
    
    
    private let trackName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .yellow
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trackImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 12
        image.layer.shadowOffset = CGSize(width: 4, height: 4)
        image.layer.shadowRadius = 4
        image.layer.shadowColor = UIColor.white.cgColor
        image.layer.shadowOpacity = 0.7
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let timeView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - настройка кнопок (создали отдельный класс customButton)
    
    private lazy var playAndPauseButton = PlayerButton(image: "play.fill")
    private lazy var stopButton = PlayerButton(image: "stop.fill")
    private lazy var nextTrackButton = PlayerButton(image: "forward.fill")
    private lazy var backwardTrackButton = PlayerButton(image: "backward.fill")
    
    private let minSound = PlayerButton(image: "speaker.wave.1.fill")
    private let maxSound = PlayerButton(image: "speaker.wave.3.fill")
    
    // создаем ButtonStack (кнопка перемотки назад/вперед, кнопка play/pause, кнопка stop и располагаем их по всей длине)
    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 35.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // создаем ползунок длины трека (отображает длительность и трека и на каком этапе находится трек)
    private let timeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .white
        slider.maximumTrackTintColor = .white
        slider.minimumTrackTintColor = .yellow
        slider.thumbTintColor = .yellow
        slider.minimumValue = 0.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        // таргет на кнопку
        slider.addTarget(PlayerController.self, action: #selector(rewindTime), for: .valueChanged)
        return slider
    }()
    
    // создаем ползунок громкости
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .white
        slider.maximumTrackTintColor = .white
        slider.minimumTrackTintColor = .yellow
        slider.thumbTintColor = .yellow
        slider.minimumValue = 0.0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.translatesAutoresizingMaskIntoConstraints = false
        //target на кнопку
        slider.addTarget(self, action: #selector(changeVolume), for: .valueChanged)
        return slider
    }()
    
    // время при старте трека
    private let elapsedTimeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // дительность (сколько времени осталось до конца) трека
    private let remainingTimeValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // создаем SoundStack (все значки )
    private lazy var soundStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // создать полоску в плеере
    private lazy var strip: UIView = {
       let strip = UIView()
        strip.backgroundColor = .white
        strip.layer.cornerRadius = 2
        strip.translatesAutoresizingMaskIntoConstraints = false
        return strip
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupPlayer()
        addButtons()
        addConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.stop()
    }
    //добавляем view, включая stack
    func addViews() {
        view.addSubview(timeView)
        view.addSubview(artistName)
        view.addSubview(trackImage)
        view.addSubview(trackName)
        view.addSubview(timeSlider)
        view.addSubview(buttonStack)
        view.addSubview(elapsedTimeValueLabel)
        view.addSubview(remainingTimeValueLabel)
        view.addSubview(soundStack)
        
        view.addSubview(strip)
        
        buttonStack.addArrangedSubview(backwardTrackButton)
        buttonStack.addArrangedSubview(playAndPauseButton)
        buttonStack.addArrangedSubview(stopButton)
        buttonStack.addArrangedSubview(nextTrackButton)
        
        soundStack.addArrangedSubview(minSound)
        soundStack.addArrangedSubview(volumeSlider)
        soundStack.addArrangedSubview(maxSound)
    }
    
    //MARK: - Player configuration
    private func setupPlayer() {
        
        let track = TrackModel.tracks[trackPosition]
        
        trackImage.image = track.image
        trackName.text = track.trackName
        artistName.text = track.artistName
        
        guard let path = Bundle.main.path(forResource: track.fileName, ofType: "mp3") else {
            return
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updatePlayback), userInfo: nil, repeats: true)
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            player = try AVAudioPlayer(contentsOf: url)
            player.volume = 0.5
            timeSlider.maximumValue = Float(player.duration)
            player.prepareToPlay()
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    // настройка кнопок (play, stop, next, previous)
    func addButtons() {
        playAndPauseButton.buttonAction = { [self] in
            if player.isPlaying {
                playAndPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                player.stop()
            } else {
                playAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                player.play()
            }
        }
        stopButton.buttonAction = { [self] in
            player.stop()
            playAndPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.currentTime = 0.0
            timeSlider.value = 0.0
        }
        
        nextTrackButton.buttonAction = { [self] in
            if trackPosition + 1 < TrackModel.tracks.count {
                trackPosition += 1
                setupPlayer()
                player.play()
                playAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
            
            if trackPosition == 0 {
                nextTrackButton.isEnabled = false
            }
        }
            
        backwardTrackButton.buttonAction = { [self] in
            if trackPosition != 0 {
                trackPosition -= 1
                setupPlayer()
                player.play()
                playAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                nextTrackButton.isEnabled = true
            }
        }
        
        minSound.buttonAction = { [self] in
            volumeSlider.value = volumeSlider.minimumValue
            player.volume = volumeSlider.value
        }
        
        maxSound.buttonAction = { [self] in
            volumeSlider.value = volumeSlider.maximumValue
            player.volume = volumeSlider.value
        }
    }
    
    @objc func updatePlayback() {
        timeSlider.value = Float(player.currentTime)
        let remainingTime = player.duration - player.currentTime
        remainingTimeValueLabel.text = formattedTime(timeInterval: remainingTime)
        elapsedTimeValueLabel.text = formattedTime(timeInterval: player.currentTime)
    }
    
    // перемотка
    @objc func rewindTime(sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
        player.play()
    }
    
    // изменение громкости
    @objc func changeVolume() {
        self.player.volume = volumeSlider.value
    }
    
    private func formattedTime(timeInterval: TimeInterval) -> String {
        
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minString = timeFormatter.string(from: NSNumber(value: mins)), let secString = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "0:00"
        }
        return "\(minString) : \(secString)"
    }
    
    //MARK: - Constraints
    func addConstraints() {
        
        timeView.edgesToSuperview()
        
      // полоска над картинкой
        strip.bottomToTop(of: trackImage, offset: -37)
        strip.centerX(to: timeView)
        strip.width(28)
        strip.height(4)
        
        // обложка трека
        trackImage.top(to: timeView, offset: 100)
        trackImage.centerX(to: timeView)
        trackImage.width(300)
        trackImage.height(300)
        
        // звуковая дорожка
        timeSlider.topToBottom(of: trackImage, offset: 45)
        timeSlider.left(to: timeView, offset: 35)
        timeSlider.right(to: timeView, offset: -35)
        
        // имя исполнителя
        artistName.topToBottom(of: timeSlider, offset: 30)
        artistName.centerX(to: timeView)
        
        // название трека
        trackName.topToBottom(of: artistName, offset: 12)
        trackName.centerX(to: timeView)
        
        // время начала трека
        elapsedTimeValueLabel.bottomToTop(of: timeSlider, offset: -10)
        elapsedTimeValueLabel.left(to: timeView, offset: 16)
        
        // время конца трека (продолжение трека)
        remainingTimeValueLabel.bottomToTop(of: timeSlider, offset: -10)
        remainingTimeValueLabel.right(to: timeView, offset: -16)
        
        //stack с кнопками(play/pause, stop etc)
        buttonStack.centerX(to: timeView)
        buttonStack.topToBottom(of: trackName, offset: 35)
        
        // ползунок громкости и иконки громкости
        soundStack.centerX(to: timeView)
        soundStack.topToBottom(of: buttonStack, offset: 45)
        soundStack.left(to: timeView, offset: 20)
        soundStack.right(to: timeView, offset: -20)
    }
}
